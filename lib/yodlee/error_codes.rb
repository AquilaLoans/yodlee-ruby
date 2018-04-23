module Yodlee
  # @see https://developer.yodlee.com/faqs/error_codes
  # @see https://developer.yodlee.com/Yodlee_API/docs/v1_1/Migrating_Yodlee_API_1_0_To_1_1#status_map

  # Not Errors
  NOT_ERRORS = [
    0,   # OK
    801, # REFRESH_NEVER_DONE
    802, # REFRESH_NEVER_DONE_AFTER_CREDENTIALS_UPDATE
  ].freeze

  # Account locked at end site.
  ACCOUNT_LOCKED = [
    407 # STATUS_ACCOUNT_LOCKED
  ].freeze

  # Additional MFA information needed at end site OR Doc download requires additional verification.
  ADDL_AUTHENTICATION_REQUIRED = [
    518, # NEW_MFA_INFO_REQUIRED_FOR_AGENTS
    519, # MFA_INFO_NOT_PROVIDED_TO_YODLEE_BY_USER_FOR_AGENTS
    520, # MFA_INFO_MISMATCH_FOR_AGENTS
    522, # MFA_INFO_NOT_PROVIDED_IN_REAL_TIME_BY_USER_VIA_APP
    573
  ].freeze

  # Beta site.
  BETA_SITE_DEV_IN_PROGRESS = [
    507 # BETA_SITE_WORK_IN_PROGRESS
  ].freeze

  # Login errors due to incorrect/outdated credentials.
  CREDENTIALS_UPDATE_NEEDED = [
    410,
    420, # STATUS_SITE_MERGED_ERROR
    526, # INVALID_MFA_INFO_OR_CREDENTIALS
  ].freeze

  # Login errors due to incorrect credentials.
  INCORRECT_CREDENTIALS = [
    402, # STATUS_LOGIN_FAILED
    551
  ].freeze

  # Data/Document not available at the end site.
  DATA_NOT_AVAILABLE = [
    414, # STATUS_NO_ACCT_FOUND
    422, # STATUS_ACCOUNT_CANCELED
    423, # STATUS_ACCT_INFO_UNAVAILABLE
    570
  ].freeze

  # MFA Information provided is invalid.
  INVALID_ADDL_INFO_PROVIDED = [
    509, # TOKEN_ID_INVALID
    523, # INVALID_MFA_INFO_IN_REAL_TIME_BY_USER_VIA_APP
    524, # USER_PROVIDED_REAL_TIME_MFA_DATA_EXPIRED
  ].freeze

  # All time out errors.
  REQUEST_TIME_OUT = [
    508, # INSTANT_REQUEST_TIMEDOUT
    525, # MFA_INFO_NOT_PROVIDED_IN_REAL_TIME_BY_GATHERER
    553,
    554,
    555
  ].freeze

  # Yodlee IP Blocked.
  SITE_BLOCKING_ERROR = [
    426, # STATUS_SITE_BLOCKING
  ].freeze

  # All errors related to end site issues such as site down for maintenance.
  UNEXPECTED_SITE_ERROR = [
    401, # NO_CONNECTION
    412, # STATUS_SITE_APPLICATION_ERROR
    418, # STATUS_HTTP_DNS_ERROR_EXCEPTION
    425, # STATUS_CERTIFICATE_ERROR
    431,
    432,
    556,
    558,
    571
  ].freeze

  # All errors where support is not available to complete the requested action. Example- Site not available, Document download not supported at site etc.
  SITE_NOT_SUPPORTED = [
    411, # STATUS_SITE_OUT_OF_BUSINESS
    417, # STATUS_DATA_MODEL_NO_SUPPORT
    421,
    430, # STATUS_SITE_NOT_SUPPORTED
    505, # STATUS_SITE_CURRENTLY_NOT_SUPPORTED
  ].freeze

  # The requested datasets are not supported
  DATASET_NOT_SUPPORTED = [
    575
  ].freeze

  # Site unavailable due to issue such as site down for maintenance.
  SITE_UNAVAILABLE = [
    409, # STATUS_SITE_UNAVAILABLE
    424, # STATUS_SITE_DOWN_FOR_MAINTENANCE
  ].freeze

  # All technical errors.
  TECH_ERROR = [
    400,
    403, # INTERNAL_ERROR
    404, # LOST_REQUEST
    408, # DATA_EXPECTED
    413, # REQUIRED_FIELD_UNAVAILABLE
    419, # LOGIN_NOT_COMPLETED
    517, # GENERAL_EXCEPTION_WHILE_GATHERING_MFA_DATA
    557,
    601,
    708,
    709, # STATUS_FIELD_NOT_AVAILABLE
    552,
    559,
    560,
    561,
    572,
    576,
    577,
    578,
    579
  ].freeze

  # All errors that need a user action at the end site. Example- Accept T&C, etc.
  USER_ACTION_NEEDED_AT_SITE = [
    406, # STATUS_PASSWORD_EXPIRED
    427, # STATUS_SPLASH_PAGE_EXCEPTION
    428, # STATUS_TERMS_AND_CONDITIONS_EXCEPTION
    429, # STATUS_UPDATE_INFORMATION_EXCEPTION
    521, # ENROLL_IN_MFA_AT_SITE
  ].freeze

  # Errors related to multiple sessions or session terminated by end site.
  SITE_SESSION_INVALIDATED = [
    415, # STATUS_SITE_TERMINATED_SESSION
    416, # STATUS_SITE_SESSION_ALREADY_ESTABLISHED
  ].freeze

  # Enrollment needed for a requested dataset at the end site.
  ENROLLMENT_REQUIRED_FOR_DATASET = [
    574
  ].freeze

  # Failed data retrieval.
  DATA_RETRIEVAL_FAILED = [
    504 # MULTIPLE_ERROR
  ].freeze

  # Partial Data retrieved.
  PARTIAL_DATA_RETRIEVED = [
    811 # PARTIAL_SUCCESS
  ].freeze

  # The site has requested for OAuth authentication.
  NEW_AUTHENTICATION_REQUIRED = [
    506 # NEW_LOGIN_INFO_REQUIRED_FOR_SITE
  ].freeze

  # Failed data retrieval.
  DATA_RETRIEVAL_FAILED = [
    510, # STATUS_PROPERTY_RECORD_NOT_FOUND
    511, # STATUS_HOME_VALUE_NOT_FOUND
    405, # STATUS_USER_ABORTED_REQUEST
    421, # STATUS_UNSUPPORTED_LANGUAGE_ERROR
    433, # STATUS_REGISTRATION_PARTIAL_SUCCESS
    434, # STATUS_REGISTRATION_FAILED_ERROR
    435, # STATUS_REGISTRATION_INVALID_DATA
    436, # REGISTRATION_ACCOUNT_ALREADY_REGISTERED
    512, # NO_PAYEES_ARE_FOUND_ON_SOURCE
  ].freeze
end
