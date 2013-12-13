 require 'rest_client'
 require 'json'

  header =  '{
   "to": [
     "ben@sendgrid.com",
     "joe@sendgrid.com"
   ],
   "sub": {
     "%name%": [
       "Ben",
       "Joe"
     ],
     "%role%": [
       "%sellerSection%",
       "%buyerSection%"
     ]
   },
   "section": {
     "%sellerSection%": "Seller information for: %name%",
     "%buyerSection%": "Buyer information for: %name%"
   },
   "category": "Orders",
   "unique_args": {
     "orderNumber": "12345",
     "eventID": "6789"
   },
   "filters": {
     "footer": {
       "settings": {
         "enable": 1,
         "text/plain": "Thank you for your business"
       }
     }
   }
 }
'
jsoned =  JSON.parse(header).to_json
# puts jsoned


 response = RestClient.post  'http://www.abemail.net/email_processor', {'X-SMTPAPI'=> jsoned}, :content_type => :json, :accept => :json

 puts response