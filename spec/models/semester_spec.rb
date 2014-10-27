require 'spec_helper'

RSpec.describe Semester do

  describe 'custom validations' do
    it 'should not allow overlapping'
  end

  describe '.current_semester' do
    context 'when included' do
      it 'should return it if in the middle' do
        d = Date.today
        s1 = Semester.create(name: 'current semester',
                        start_date: d - 5.days,
                        end_date: d + 5.days  )
        s2 = Semester.create(name: 'bad semester',
                        start_date: d - 20.days,
                        end_date: d - 10.days  )
        expect(Semester.current_semester).to eql(s1)
      end

      it 'should return it if on start date' do
        d = Date.today
        s1 = Semester.create(name: 'current semester',
                        start_date: d,
                        end_date: d + 5.days  )
        s2 = Semester.create(name: 'bad semester',
                        start_date: d - 20.days,
                        end_date: d - 10.days  )
        expect(Semester.current_semester).to eql(s1)
      end

      it 'should return it if on end date' do
        d = Date.today
        s1 = Semester.create(name: 'current semester',
                        start_date: d - 5.days,
                        end_date: d )
        s2 = Semester.create(name: 'bad semester',
                        start_date: d - 20.days,
                        end_date: d - 10.days  )
        expect(Semester.current_semester).to eql(s1)
      end
    end

    context 'when not included' do
      it 'should return nil if no semesters' do
        expect(Semester.current_semester).to be_nil
      end

      it 'should return nil if no relevant semesters' do
        d = Date.today
        s1 = Semester.create(name: 'current semester',
                        start_date: d + 5.days,
                        end_date: d + 10.days )
        s2 = Semester.create(name: 'bad semester',
                        start_date: d - 20.days,
                        end_date: d - 10.days  )
        expect(Semester.current_semester).to be_nil
      end
    end
  end

  after(:each) do
    Semester.delete_all
  end
end
