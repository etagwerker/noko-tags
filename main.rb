require "dotenv"
require "noko"

Dotenv.load

TAGS = %w{
BizDev
OmbuTalk
RailsConf
UX
calls
customer-service
dash
documentation
english
extrahours
fastRuby
followup
interview
invoices
ombulabs
ombushop
onboarding
one
pair
payroll
pecas
points
projectManagement
skunk
unbillable
}.sort

noko = Noko::Client.new(token: ENV.fetch('NOKO_TOKEN'))

17.times do
  noko.get_tags.each do |tag|
    if TAGS.map(&:downcase).include?(tag.name.downcase)
      puts "KEEP: #{tag.name}"
    else
      puts "DELETE: #{tag.name} (#{tag.id})"
      noko.delete_tag(tag.id)
      sleep(1)
    end
  end
end
