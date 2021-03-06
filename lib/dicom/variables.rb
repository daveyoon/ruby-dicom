module DICOM

  class << self

    #--
    # Module attributes:
    #++

    # The ruby-dicom image processor to be used.
    attr_accessor :image_processor
    # The key representation for hashes, json, yaml.
    attr_accessor :key_representation
    # Source Application Entity Title (gets written to the DICOM header in files where it is undefined).
    attr_accessor :source_app_title

    #--
    # Module methods:
    #++

    # Generates a unique identifier string.
    # The UID is composed of a DICOM root UID, a type prefix,
    # a datetime part and a random number part.
    #
    # @param [String] root the DICOM root UID to be used for generating the UID string
    # @param [String] prefix an integer string which is placed between the dicom root and the time/random part of the UID
    # @return [String] the generated unique identifier
    # @example Create a random UID with specified root and prefix
    #   uid = DICOM.generate_uid('1.2.840.999', '5')
    #
    def generate_uid(root=UID_ROOT, prefix=1)
      # NB! For UIDs, leading zeroes immediately after a dot is not allowed.
      date = Time.now.strftime("%Y%m%d").to_i.to_s
      time = Time.now.strftime("%H%M%S").to_i.to_s
      random = rand(99999) + 1 # (Minimum 1, max. 99999)
      uid = [root, prefix, date, time, random].join('.')
      return uid
    end

    # Use tags as key. Example: '0010,0010'
    #
    def key_use_tags
      @key_representation = :tag
    end

    # Use names as key. Example: "Patient's Name"
    #
    def key_use_names
      @key_representation = :name
    end

    # Use method names as key. Example: :patients_name
    #
    def key_use_method_names
      @key_representation = :name_as_method
    end

  end

  #--
  # Default variable settings:
  #++

  # The default image processor.
  self.image_processor = :rmagick
  # The default key representation.
  self.key_representation = :name
  # The default source application entity title.
  self.source_app_title = 'RUBY_DICOM'

end