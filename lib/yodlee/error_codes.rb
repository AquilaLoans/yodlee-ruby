module Yodlee
  # @see https://developer.yodlee.com/faqs/error_codes
  # Not Errors
  NOT_ERRORS = [
    OK                                          = 0,
    REFRESH_NEVER_DONE                          = 801,
    REFRESH_NEVER_DONE_AFTER_CREDENTIALS_UPDATE = 802
  ].freeze

  # Site Errors
  SITE_ERRORS = [
    STATUS_SITE_UNAVAILABLE                 = 409,
    STATUS_SITE_OUT_OF_BUSINESS             = 411,
    STATUS_SITE_APPLICATION_ERROR           = 412,
    STATUS_SITE_TERMINATED_SESSION          = 415,
    STATUS_SITE_SESSION_ALREADY_ESTABLISHED = 416,
    STATUS_HTTP_DNS_ERROR_EXCEPTION         = 418,
    STATUS_ACCT_INFO_UNAVAILABLE            = 423,
    STATUS_SITE_DOWN_FOR_MAINTENANCE        = 424,
    STATUS_CERTIFICATE_ERROR                = 425,
    STATUS_SITE_BLOCKING                    = 426,
    STATUS_SITE_CURRENTLY_NOT_SUPPORTED     = 505,
    STATUS_PROPERTY_RECORD_NOT_FOUND        = 510,
    STATUS_HOME_VALUE_NOT_FOUND             = 511
  ].freeze

  # User Account Errors
  USER_ACCOUNT_ERRORS = [
    STATUS_LOGIN_FAILED                                = 402,
    STATUS_USER_ABORTED_REQUEST                        = 405,
    STATUS_PASSWORD_EXPIRED                            = 406,
    STATUS_ACCOUNT_LOCKED                              = 407,
    STATUS_NO_ACCT_FOUND                               = 414,
    STATUS_DATA_MODEL_NO_SUPPORT                       = 417,
    STATUS_SITE_MERGED_ERROR                           = 420,
    STATUS_UNSUPPORTED_LANGUAGE_ERROR                  = 421,
    STATUS_ACCOUNT_CANCELED                            = 422,
    STATUS_SPLASH_PAGE_EXCEPTION                       = 427,
    STATUS_TERMS_AND_CONDITIONS_EXCEPTION              = 428,
    STATUS_UPDATE_INFORMATION_EXCEPTION                = 429,
    STATUS_SITE_NOT_SUPPORTED                          = 430,
    STATUS_REGISTRATION_PARTIAL_SUCCESS                = 433,
    STATUS_REGISTRATION_FAILED_ERROR                   = 434,
    STATUS_REGISTRATION_INVALID_DATA                   = 435,
    REGISTRATION_ACCOUNT_ALREADY_REGISTERED            = 436,
    NEW_LOGIN_INFO_REQUIRED_FOR_SITE                   = 506,
    NO_PAYEES_ARE_FOUND_ON_SOURCE                      = 512,
    NEW_MFA_INFO_REQUIRED_FOR_AGENTS                   = 518,
    MFA_INFO_NOT_PROVIDED_TO_YODLEE_BY_USER_FOR_AGENTS = 519,
    MFA_INFO_MISMATCH_FOR_AGENTS                       = 520,
    ENROLL_IN_MFA_AT_SITE                              = 521,
    MFA_INFO_NOT_PROVIDED_IN_REAL_TIME_BY_USER_VIA_APP = 522,
    INVALID_MFA_INFO_IN_REAL_TIME_BY_USER_VIA_APP      = 523,
    USER_PROVIDED_REAL_TIME_MFA_DATA_EXPIRED           = 524,
    INVALID_MFA_INFO_OR_CREDENTIALS                    = 526
  ].freeze

  # Agent Errors
  AGENT_ERRORS = [
    NO_CONNECTION                                  = 401,
    INTERNAL_ERROR                                 = 403,
    LOST_REQUEST                                   = 404,
    DATA_EXPECTED                                  = 408,
    REQUIRED_FIELD_UNAVAILABLE                     = 413,
    LOGIN_NOT_COMPLETED                            = 419,
    BETA_SITE_WORK_IN_PROGRESS                     = 507,
    INSTANT_REQUEST_TIMEDOUT                       = 508,
    TOKEN_ID_INVALID                               = 509,
    GENERAL_EXCEPTION_WHILE_GATHERING_MFA_DATA     = 517,
    MFA_INFO_NOT_PROVIDED_IN_REAL_TIME_BY_GATHERER = 525,
    STATUS_FIELD_NOT_AVAILABLE                     = 709
  ].freeze

  # Generic Errors
  GENERIC_ERRORS = [
    PARTIAL_SUCCESS = 811,
    MULTIPLE_ERROR  = 504
  ].freeze
end
