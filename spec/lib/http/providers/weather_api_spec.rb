RSpec.describe SimpleWeather::HTTP::Providers::WeatherApi do
  let(:subject) { described_class.new }

  describe '#build_url_for' do
    let(:method_call) { subject.build_url_for(request_name, params, units: units) }

    let(:units) { 'metric' }


    context 'with :current_weather' do
      let(:request_name) { :current_weather }
      let(:params) { { lat: 1.333, lon: 2.555 } }

      it 'contains params' do
        params.values.each do |param|
          expect(method_call).to include param.to_s
        end
      end

      it 'builds valid url' do
        expect(method_call).to match URI::regexp
      end
    end

    context 'with :history' do
      let(:request_name) { :history_weather }
      let(:params) { { lat: 1.333, lon: 2.555, date: Date.today.iso8601 } }

      it 'contains params' do
        params.values.each do |param|
          expect(method_call).to include param.to_s
        end
      end

      it 'builds valid url' do
        expect(method_call).to match URI::regexp
      end
    end
  end
end
