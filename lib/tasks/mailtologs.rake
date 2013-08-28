require 'net/imap'

namespace :logs do 
  desc "Create Single User"
  task frommail: :environment do
    imap = Net::IMAP.new('newmailhost.cc.iitk.ac.in')
    imap.authenticate('LOGIN', '#####', '********')
    imap.select('INBOX.Sent')
    
    # count = 0
    months = %w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
    (4..30).each do |i|
      start="1-#{months[i%12]}-#{2011+(i/12)}"
      stop="1-#{months[(i+1)%12]}-#{2011+((i+1)/12)}"
      puts "From : #{start}"
      #dir="/home/shubtri/Trackr"
      #f = File.new("#{dir}#{start}-SENT.csv","w")
      #f.write "Name,Email,Company,Subject,Date,Body\n"
      imap.search(["BEFORE", stop, "SINCE", start]).each do |message_id|
        envelope = imap.fetch(message_id, "ENVELOPE")[0].attr["ENVELOPE"]
        subject = envelope.subject
        toid=""
        ccid=""
        bccid=""
        date=envelope.date
        body=imap.fetch(message_id, "BODY[TEXT]")[0].attr["BODY[TEXT]"]
        subject.sub!(',',' ') if subject
        if envelope.to
          envelope.to.each do |to|
            name = to.name
            email_id = to.mailbox
            domain = to.host
            probable_company=domain.split('.')[0] if domain
            name.sub!(',',' ') if name
            toid=to.mailbox+"@"+domain+","+toid
            #f.write "#{name},#{email_id}@#{domain},#{probable_company},#{subject},#{date},#{body}\n".force_encoding('UTF-8')
          end
        end
        puts toid
        if envelope.cc 
          envelope.cc.each do |cc|
            name = cc.name
            email_id = cc.mailbox
            domain = cc.host
            probable_company=domain.split('.')[0] if domain
            name.sub!(',',' ') if name
            ccid=cc.mailbox+"@"+domain+","+ccid
            #f.write "#{name},#{email_id}@#{domain},#{probable_company},#{subject},#{date},#{body}\n".force_encoding('UTF-8')
          end
        end
        puts ccid
        if envelope.bcc 
          envelope.bcc.each do |bcc|
            name = bcc.name
            email_id = bcc.mailbox
            domain = bcc.host
            probable_company=domain.split('.')[0] if domain
            name.sub!(',',' ') if name
            bccid=bcc.mailbox+"@"+domain+","+bccid
            #f.write "#{name},#{email_id}@#{domain},#{probable_company},#{subject},#{date},#{body}\n".force_encoding('UTF-8')
          end
        end
        puts bccid
      Mail.create!(to:toid,cc:ccid,bcc:bccid,subject:subject,body:body)
      end
      puts "Till : #{stop}"
    end
  end
end
