import { Module } from '@nestjs/common';
import { CentralAuditController, StaffController } from './staff.controller.ts';
import { ProviderAuditController, TeamController } from './team.controller.ts';

@Module({
  controllers: [TeamController, ProviderAuditController, StaffController, CentralAuditController],
})
export class AccessModule {}
