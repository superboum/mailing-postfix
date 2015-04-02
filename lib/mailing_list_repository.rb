require_relative 'mailing_list.rb'

class MailingListRepository
    def initialize(file)
        @file = file
        @lists = Array.new
    end

    def load()
        raw = File.read(@file)
        raw.each_line do |line|
            unless line.split.empty? then
                @lists.push(MailingList.new(line)) 
            end
        end
    end

    def list(n)
        @lists[n]
    end

    def add(email)
        @lists.push(MailingList.new(email))
    end

    def save()
        File.write(@file, to_s())
    end

    def to_s()
        r = ""
        @lists.each do |l|
            r += l.to_s
        end
        r
    end
end
