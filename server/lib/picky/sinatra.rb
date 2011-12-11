module Picky

  # This Module is used to install delegator methods
  # into the class for use with Sinatra.
  #
  module Sinatra

    # Privatizes app file methods.
    #
    def self.extended into
      private :indexing, :searching
    end

    # Sets tokenizer default indexing options.
    #
    def indexing options = {}
      Tokenizer.indexing options
    end

    # Sets tokenizer default searching options.
    #
    def searching options = {}
      Tokenizer.searching options
    end

  end

end

# Check if toplevel Sinatra picky methods need to be installed.
#
if private_methods.include? :get
  extend Picky::Sinatra
end