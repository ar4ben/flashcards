class ApplicationMailer < ActionMailer::Base
  default from: "postmaster@flashcards.com"
  layout 'mailer'
end
