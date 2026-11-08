import { Module } from '@nestjs/common';
import { ProductsController } from './products.controller.ts';
import { ProductsService } from './products.service.ts';
import { ReviewController } from './review.controller.ts';

@Module({
  controllers: [ProductsController, ReviewController],
  providers: [ProductsService],
  exports: [ProductsService],
})
export class ProductsModule {}
