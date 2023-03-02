class EmailBounceController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
    bounce_attribs = safe_params.to_h.map { |k, v| [k.underscore.to_sym, v] }.to_h
    # rename type attribute because it's a reseved word
    bounce_attribs[:bounce_type] = bounce_attribs.delete(:type)
    email_bounce = EmailBounce.create(bounce_attribs)
    NotifySpamBounceJob.perform_later(email_bounce.id) if email_bounce.type_code == 512
    head :no_content
  end

  private

  def safe_params
    params.permit(:RecordType, :Type, :TypeCode, :Name, :Tag, :MessageStream, :Description, :Email, :From, :BouncedAt)
  end
end
