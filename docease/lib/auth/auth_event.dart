
import 'package:docease_1/model/auth_response.dart';
import 'package:docease_1/regenToken.dart';
import 'package:equatable/equatable.dart';



abstract class AuthEvent extends Equatable {}

class APIDetailsEvent extends AuthEvent {
  APIDetailsEvent({required this.accountId});

  final String accountId;

  @override
  List<Object?> get props => [accountId];
}

class GetAuthTokenEvent extends AuthEvent {
  final AuthRequest authrequest;

  GetAuthTokenEvent(this.authrequest);

  @override
  List<Object?> get props =>
      [authrequest];
}

class RegenTokenEvent extends AuthEvent {
  final RegenTokenRequestBody regenTokenRequestBody;

  RegenTokenEvent(this.regenTokenRequestBody);

  @override
  List<Object?> get props =>
      [regenTokenRequestBody];
}

