require 'spec_helper'

describe "/batches/show.html.erb" do
  include BatchesHelper
  before(:each) do
    assigns[:batch] = @batch = stub_model(Batch)
  end

  it "renders attributes in <p>" do
    render
  end
end
