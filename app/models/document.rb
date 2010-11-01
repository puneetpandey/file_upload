class Document < ActiveRecord::Base
  has_many :attachments, :dependent => :destroy
  belongs_to :user

  validates_presence_of :name
  accepts_nested_attributes_for :attachments
end
