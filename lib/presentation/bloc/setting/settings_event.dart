abstract class SettingsEvent {
  const SettingsEvent();
}

class StartSettingsEvent extends SettingsEvent {
  const StartSettingsEvent();
}

class SetSubscribedPackageEvent extends SettingsEvent {
  const SetSubscribedPackageEvent(
    //  this.currentPackage,
    this.superMessageCount,
    this.jobPostingCount,
  );

  //final SubscribedPackage currentPackage;
  final int superMessageCount;
  final int jobPostingCount;
}

class SettingsDeleteAccount extends SettingsEvent {
  const SettingsDeleteAccount(
      {required this.email, required this.userType, required this.id});

  final String email;
  final String userType;
  final String id;
}

class SendOTPForChange extends SettingsEvent {
  const SendOTPForChange({
    required this.sendTo,
    required this.signInOption,
  });

  final String sendTo;
  final String signInOption;
}

class ExecuteChange extends SettingsEvent {
  const ExecuteChange();
}

class SelectPlanEvent extends SettingsEvent {
 // const SelectPlanEvent(this.package);

  //final SubscriptionPackage package;
}

class SelectPlanDurationEvent extends SettingsEvent {
  const SelectPlanDurationEvent(this.planDuration);

  final String planDuration;
}

class SubscribeEvent extends SettingsEvent {
  const SubscribeEvent();
}
