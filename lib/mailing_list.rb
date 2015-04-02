class MailingList
    attr_accessor :subscribers, :mailing

    def initialize(raw)
        @subscribers = raw.split
        @mailing = @subscribers.shift
    end

    def addSubscriber(email)
        @subscribers.push(email)
        @subscribers = @subscribers.uniq
    end

    def removeSubscriber(email)
        @subscribers.delete(email)
    end

    def changeMailing(email)
        @mailing = email
    end

    def to_s()
        @mailing + " " + @subscribers.join(" ") + "\n"
    end

end
