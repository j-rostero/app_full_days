import { Inject, Injectable } from '@nestjs/common';
import type { File, PrismaClient, Provider, ProviderDocument } from '@fulldays/db';
import {
  providerBadge,
  REQUIRED_PROVIDER_DOCUMENTS,
  type ProviderDocumentType,
} from '@fulldays/shared';
import { DB } from '../common/tokens.ts';
import { FilesService } from '../files/files.service.ts';
import type { Company, ProviderDocumentView } from './providers.schemas.ts';

@Injectable()
export class ProvidersService {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(FilesService) private readonly files: FilesService,
  ) {}

  async company(provider: Provider, db: PrismaClient = this.db): Promise<Company> {
    const docs = await db.providerDocument.findMany({
      where: { providerId: provider.id },
      select: { type: true },
    });
    return toCompany(
      provider,
      docs.map((d) => d.type),
    );
  }

  async documents(providerId: string, db: PrismaClient = this.db): Promise<ProviderDocumentView[]> {
    const rows = await db.providerDocument.findMany({
      where: { providerId },
      include: { file: true },
      orderBy: { createdAt: 'asc' },
    });
    return Promise.all(rows.map((row) => this.document(row)));
  }

  async document(row: ProviderDocument & { file: File }): Promise<ProviderDocumentView> {
    return {
      id: row.id,
      type: row.type,
      fileId: row.fileId,
      contentType: row.file.contentType,
      downloadUrl: await this.files.storage.downloadUrl(
        'documents',
        row.file.key,
        `${row.type}-${row.file.key}`,
      ),
      createdAt: row.createdAt.toISOString(),
    };
  }
}

export function toCompany(provider: Provider, documentTypes: ProviderDocumentType[]): Company {
  return {
    id: provider.id,
    kind: provider.kind,
    name: provider.name,
    legalName: provider.legalName,
    rif: provider.rif,
    rtn: provider.rtn,
    baseCity: provider.baseCity,
    phone: provider.phone,
    instagram: provider.instagram,
    paymentInstructions: provider.paymentInstructions,
    status: provider.status,
    statusReason: provider.statusReason,
    badge: providerBadge(provider),
    commissionPercent:
      provider.commissionPercent === null ? null : Number(provider.commissionPercent),
    missingDocuments: REQUIRED_PROVIDER_DOCUMENTS.filter((t) => !documentTypes.includes(t)),
  };
}
