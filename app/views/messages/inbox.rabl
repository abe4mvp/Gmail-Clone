collection :@messages
attributes :id, :sender, :display_recipient_emails, :time_stamp, :subject, :body, :preview, :sender_id
child(:flags) do
  attributes read: :read, heart: :heart, trashed: :trashed
end
