require_relative 'mailing_list.rb'

class MailingListRepository

    attr_accessor :file, :lists, :reload_cmd

    def initialize(file, reload_cmd)
        @file = file
        @lists = Array.new
        @reload_cmd = reload_cmd
    end

    def load()
        raw = File.read(@file)
        raw.each_line do |line|
            unless line.split.empty? then
                @lists.push(MailingList.new(line)) 
            end
        end
    end

    def add(email)
        @lists.push(MailingList.new(email))
    end

    def rm(id)
        @lists.delete_at(id)
    end

    def save()
        File.write(@file, to_s())
        system(@reload_cmd)
    end

    def to_s()
        r = ""
        @lists.each do |l|
            r += l.to_s
        end
        r
    end
end
