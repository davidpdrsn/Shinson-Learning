require 'spec_helper'

describe LogsController do
  describe "#create" do
    it "should create a log entry" do
      fake_logger = double.as_null_object
      allow(controller).to receive(:logger).and_return(fake_logger)
      allow(fake_logger).to receive(:info).with "log message"

      post :create, message: "log message"
      expect(fake_logger).to have_received(:info).with "log message"
    end
  end
end
