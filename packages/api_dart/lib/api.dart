//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/agencia_api.dart';
part 'api/archivos_api.dart';
part 'api/auditoria_api.dart';
part 'api/auth_api.dart';
part 'api/catalogos_api.dart';
part 'api/central_api.dart';
part 'api/equipo_api.dart';
part 'api/productos_api.dart';
part 'api/salidas_api.dart';
part 'api/salud_api.dart';
part 'api/yo_api.dart';

part 'model/account.dart';
part 'model/add_team_member_input.dart';
part 'model/api_error.dart';
part 'model/api_error_issues_inner.dart';
part 'model/attach_document_input.dart';
part 'model/audit_entry.dart';
part 'model/audit_entry_actor.dart';
part 'model/audit_page.dart';
part 'model/boarding_point.dart';
part 'model/boarding_point_input.dart';
part 'model/boarding_point_list.dart';
part 'model/boarding_point_update_input.dart';
part 'model/change_team_role_input.dart';
part 'model/commission_input.dart';
part 'model/company.dart';
part 'model/completeness.dart';
part 'model/completeness_blocks_inner.dart';
part 'model/create_product_input.dart';
part 'model/curation_input.dart';
part 'model/declare_file_input.dart';
part 'model/declared_file.dart';
part 'model/declared_file_upload.dart';
part 'model/departure.dart';
part 'model/departure_list.dart';
part 'model/departure_status.dart';
part 'model/departure_update_input.dart';
part 'model/destination.dart';
part 'model/destination_fee.dart';
part 'model/destination_fee_input.dart';
part 'model/destination_input.dart';
part 'model/destination_list.dart';
part 'model/destination_update_input.dart';
part 'model/file.dart';
part 'model/google_input.dart';
part 'model/health.dart';
part 'model/health_checks.dart';
part 'model/image_urls.dart';
part 'model/me.dart';
part 'model/me_staff.dart';
part 'model/membership.dart';
part 'model/passenger.dart';
part 'model/passenger_input.dart';
part 'model/passenger_list.dart';
part 'model/photo.dart';
part 'model/product_detail.dart';
part 'model/product_list.dart';
part 'model/product_queue.dart';
part 'model/product_queue_item.dart';
part 'model/product_review.dart';
part 'model/product_sheet.dart';
part 'model/product_sheet_duration.dart';
part 'model/product_sheet_general.dart';
part 'model/product_sheet_items_inner.dart';
part 'model/product_sheet_itinerary_inner.dart';
part 'model/product_sheet_lodging.dart';
part 'model/product_sheet_lodging_rooms_inner.dart';
part 'model/product_sheet_meals_inner.dart';
part 'model/product_sheet_meals_inner_options_inner.dart';
part 'model/product_sheet_pricing.dart';
part 'model/product_sheet_pricing_cancellation.dart';
part 'model/product_sheet_pricing_deposit.dart';
part 'model/product_sheet_pricing_fares.dart';
part 'model/product_sheet_transfer.dart';
part 'model/product_sheet_transfer_boarding_points_inner.dart';
part 'model/product_status.dart';
part 'model/product_summary.dart';
part 'model/product_type.dart';
part 'model/profile_update_input.dart';
part 'model/provider_document.dart';
part 'model/provider_document_list.dart';
part 'model/provider_document_type.dart';
part 'model/provider_input.dart';
part 'model/provider_permission.dart';
part 'model/provider_queue.dart';
part 'model/provider_queue_item.dart';
part 'model/provider_review.dart';
part 'model/provider_role.dart';
part 'model/provider_status.dart';
part 'model/provider_update_input.dart';
part 'model/rate.dart';
part 'model/rate_input.dart';
part 'model/rate_list.dart';
part 'model/reason_input.dart';
part 'model/recover_input.dart';
part 'model/register_input.dart';
part 'model/renew_input.dart';
part 'model/reset_input.dart';
part 'model/save_product_input.dart';
part 'model/schedule_departures_input.dart';
part 'model/set_staff_roles_input.dart';
part 'model/settings.dart';
part 'model/settings_input.dart';
part 'model/sign_in_input.dart';
part 'model/signed_in.dart';
part 'model/site.dart';
part 'model/staff_list.dart';
part 'model/staff_permission.dart';
part 'model/staff_person.dart';
part 'model/staff_role.dart';
part 'model/team_list.dart';
part 'model/team_member.dart';
part 'model/theme_input.dart';
part 'model/theme_list.dart';
part 'model/theme_update_input.dart';
part 'model/tokens.dart';
part 'model/travel_theme.dart';
part 'model/verify_input.dart';


/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient();

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) => pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';
