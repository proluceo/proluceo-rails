# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 0) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "fsm"
  enable_extension "ltree"
  enable_extension "pg_libphonenumber"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "currency", ["AFN", "EGP", "EUR", "ALL", "DZD", "USD", "AOA", "XCD", "XAF", "ARS", "AMD", "AWG", "AZN", "ETB", "AUD", "BSD", "BHD", "BDT", "BBD", "BYR", "BZD", "XOF", "BMD", "BTN", "BOB", "BAM", "BWP", "NOK", "BRL", "BND", "BGN", "BIF", "CLP", "CNY", "CKD", "CRC", "ANG", "DKK", "CDF", "DOP", "DJF", "ERN", "SZL", "FKP", "FOK", "FJD", "XPF", "GMD", "GEL", "GHS", "GIP", "GTQ", "GGP", "GNF", "GYD", "HTG", "HNL", "HKD", "INR", "IDR", "IMP", "IQD", "IRR", "ISK", "ILS", "JMD", "JPY", "YER", "JEP", "JOD", "KYD", "KHR", "CAD", "CVE", "KZT", "QAR", "KES", "KGS", "KID", "COP", "KMF", "HRK", "CUP", "KWD", "LAK", "LSL", "LBP", "LRD", "LYD", "CHF", "MOP", "MGA", "MWK", "MYR", "MVR", "MAD", "MRO", "MUR", "MXN", "MDL", "MNT", "MZN", "MMK", "NAD", "NPR", "NZD", "NIO", "NGN", "KPW", "MKD", "OMR", "PKR", "PAB", "PGK", "PYG", "PEN", "PHP", "PLN", "RWF", "RON", "RUB", "SBD", "ZMW", "WST", "STD", "SAR", "SEK", "RSD", "SCR", "SLL", "ZWL", "SGD", "SOS", "LKR", "SHP", "ZAR", "SDG", "GBP", "KRW", "SSP", "SRD", "SYP", "TJS", "TWD", "TZS", "THB", "TOP", "TTD", "CZK", "TND", "TRY", "TMT", "TVD", "UGX", "UAH", "HUF", "UYU", "UZS", "VUV", "VEF", "AED", "VND"]
  create_enum "ledger_entry_direction", ["credit", "debit"]
  create_enum "mean_of_communication", ["call", "meeting", "email"]

end
