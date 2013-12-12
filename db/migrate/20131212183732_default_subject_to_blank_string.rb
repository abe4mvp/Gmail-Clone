class DefaultSubjectToBlankString < ActiveRecord::Migration
  def change
    Message.all {|message| message.subject = "" if message.subject.nil?}
    change_column :messages, :subject, :string, deafult: ""
  end


end
