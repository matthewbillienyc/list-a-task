require 'rails_helper'

describe CreateTaskServices do
  context "create task services" do
    list = FactoryGirl.create(:list)
    task = FactoryGirl.create(:task, list_id: list.id)
    let(:add_task) { AddTaskToTotals.new(task) }
    describe "#initialize" do
      it "takes one argument" do
        expect{ add_task }.to_not raise_error
      end
      it "sets self.task to the task argument" do
        expect(add_task.task).to eq task
      end
    end

    describe "#call" do
      before :each do
        add_task.call
      end
      it "increments its list's tasks_total" do
        expect(add_task.task.list.tasks_total).to eq(1)
      end
    end
  end
end
