module RMeetup
  module Type
    module V2

      # == RMeetup::Type::V2::Group
      #
      # Data wrapper for a Group fetching response
      # Used to access result attributes as well
      # as programatically fetch relative data types
      # based on this event.
      
      # See http://www.meetup.com/meetup_api/docs/2/groups/ for available fields

      class Group < RMeetup::Type::Base

        def group
          @obj
        end

        # Special accessors that need typecasting or other parsing
        def created
          datetime_for 'created'
        end
        def updated
          datetime_for 'updated'
        end
        def time
          datetime_for 'time'
        end

        private
        def datetime_for(field)
          offset = Rational(event['utc_offset'], 24 * 60 * 60 * 1000) # hours * minutes * seconds * milliseconds
          Time.at(event[field] / 1000).to_datetime.new_offset(offset)
        end
      end
    end
  end
end
