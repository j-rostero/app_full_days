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

part 'api/auditoria_api.dart';
part 'api/auth_api.dart';
part 'api/central_api.dart';
part 'api/equipo_api.dart';
part 'api/salud_api.dart';
part 'api/yo_api.dart';

part 'model/account.dart';
part 'model/add_team_member_input.dart';
part 'model/api_error.dart';
part 'model/api_error_issues_inner.dart';
part 'model/audit_entry.dart';
part 'model/audit_entry_actor.dart';
part 'model/audit_page.dart';
part 'model/change_team_role_input.dart';
part 'model/google_input.dart';
part 'model/health.dart';
part 'model/health_checks.dart';
part 'model/me.dart';
part 'model/me_staff.dart';
part 'model/membership.dart';
part 'model/passenger.dart';
part 'model/passenger_input.dart';
part 'model/passenger_list.dart';
part 'model/profile_update_input.dart';
part 'model/provider_permission.dart';
part 'model/provider_role.dart';
part 'model/recover_input.dart';
part 'model/register_input.dart';
part 'model/renew_input.dart';
part 'model/reset_input.dart';
part 'model/set_staff_roles_input.dart';
part 'model/sign_in_input.dart';
part 'model/signed_in.dart';
part 'model/staff_list.dart';
part 'model/staff_permission.dart';
part 'model/staff_person.dart';
part 'model/staff_role.dart';
part 'model/team_list.dart';
part 'model/team_member.dart';
part 'model/tokens.dart';
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
