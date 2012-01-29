require 'spec_helper'

describe EventsController do
  describe "#index" do
    before { get :index }

    it { should respond_with(:success) }
    it { should assign_to :events }
    it { should render_template :index }
  end

  describe "#new" do
    before { get :new }

    it { should respond_with(:success) }
    it { should assign_to :event }
    it { should render_template :new }
  end

  describe "#create" do
    before(:each) do
      params = FactoryGirl.attributes_for(:event)
      post :create, :event => params
      @new_event = Event.first
    end

    it { should set_the_flash.to(/created/i) }
    it { should redirect_to event_path(@new_event) }
  end

  describe "#update" do
    before(:each) do
      @event = Factory(:event)
      put :update, :id => @event.id, :name => "New name"
    end

    it { should set_the_flash.to(/updated/i) }
    it { should redirect_to event_path(@new_event) }
  end

  describe "#show" do
    before do
      @event = Factory(:event)
      get :show, :id => @event
    end

    it { should respond_with(:success) }
    it { should assign_to :event }
    it { should render_template :show }
  end

  describe "#edit" do
    context "pre jobs finalized" do
      before do
        @event = Factory(:event, :jobs_finalized => false)
        get :edit, :id => @event
      end

      it { should respond_with(:success) }
      it { should assign_to :event }
      it { should assign_to :new_jobs }
      it { should render_template :edit }
    end

    context "post jobs finalized" do
      before do
        @event = Factory(:event, :jobs_finalized => true)
        get :edit, :id => @event
      end

      it { should respond_with(:success) }
      it { should assign_to :event }
      it { should_not assign_to :new_jobs }
      it { should render_template :edit }
    end
  end
end
