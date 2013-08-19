#!/usr/bin/env ruby

require 'net/imap'
imap = Net::IMAP.new('newmailhost.cc.iitk.ac.in')
imap.authenticate('LOGIN', '******', '********')
imap.select('INBOX')
puts "Name,Email,Company,Subject"
imap.search(["BEFORE", "30-Apr-2013", "SINCE", "1-Apr-2013"]).each do |message_id|
	envelope = imap.fetch(message_id, "ENVELOPE")[0].attr["ENVELOPE"]
	name = envelope.from[0].name
	email_id = envelope.from[0].mailbox
	domain = envelope.from[0].host
	probable_company=domain.split('.')[0]

	subject = envelope.subject
	name.sub!(',',' ') if name
	subject.sub!(',',' ') if subject
  	puts "#{name},#{email_id}@#{domain},#{probable_company},#{subject}"
end