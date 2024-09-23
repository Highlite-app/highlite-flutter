abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class AuthenticateOnStartEvent extends AuthenticationEvent {
  const AuthenticateOnStartEvent();
}

class AuthenticateOnboardingEvent extends AuthenticationEvent {
  const AuthenticateOnboardingEvent(this.id, this.userType);
  final String id;
  final String userType;
}

class AttachAuthenticationEvent extends AuthenticationEvent {
  const AttachAuthenticationEvent();
}

class AuthenticateCompanyEvent extends AuthenticationEvent {
  const AuthenticateCompanyEvent();
}

class AuthenticateCandidateEvent extends AuthenticationEvent {
  const AuthenticateCandidateEvent();
}
class LogoutEvent extends AuthenticationEvent {
  const LogoutEvent();
}
