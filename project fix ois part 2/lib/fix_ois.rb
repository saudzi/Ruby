# frozen_string_literal: true

require 'business_logic'

options = ArgumentsParser.parse_program_arguments
BusinessLogic.business_logic(options)

# w the heck
warn 'WOW!!! How did you end up here? This should newer happen.', ''
abort
