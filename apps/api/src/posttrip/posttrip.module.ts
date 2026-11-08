import { Module } from '@nestjs/common';
import { AuthModule } from '../auth/auth.module.ts';
import { AdminController } from './admin.controller.ts';
import { ClaimsController } from './claims.controller.ts';
import { ReviewsController } from './reviews.controller.ts';

@Module({
  imports: [AuthModule],
  controllers: [ReviewsController, ClaimsController, AdminController],
})
export class PosttripModule {}
