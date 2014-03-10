require 'spec_helper'

describe LogsController do
  describe "#create" do
    it "should create a log entry" do
      fake_logger = double.as_null_object
      controller.stub(:logger) { fake_logger }

      fake_logger.should_receive(:info).with "log message"

      post :create, message: "log message"
    end
  end
end
