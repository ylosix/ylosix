module ClassErrors
  class ParentLoopError < StandardError; end
  class InvalidPathError < StandardError; end
end

module ActiveRecord
  # Raised when object is not enabled
  class RecordNotEnabled < ActiveRecordError
  end
end
