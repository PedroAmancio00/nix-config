# Time zone, locale and keyboard region.
{ ... }:

{
  time.timeZone = "America/Sao_Paulo";

  # Keep the RTC in local time. Needed only because this machine dual-boots
  # with Windows, which assumes local time rather than UTC.
  time.hardwareClockInLocalTime = true;

  # Interface language stays English; regional formats (dates, currency,
  # paper size, phone numbers) follow pt_BR.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };
}
