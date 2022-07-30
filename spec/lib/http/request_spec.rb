# frozen_string_literal: true

RSpec.describe SimpleWeather::HTTP::Request do
  let(:params) { { lat: 1.22, lon: 1.33 } }
  let(:subject) { described_class.new(provider:) }
  let(:method_call) { subject.call(params, request_name:, units:) }
  let(:result) { method_call } # For naming convention

  describe '#call' do
    context 'with :metric units' do
      let(:units) { :metric }

      context 'with open_weather' do
        let(:provider) { :open_weather }

        context 'with :current method', vcr: { cassette_name: 'open_weather_current_weather_metric' } do
          let(:request_name) { :current_weather }

          it 'succeed API response' do
            expect { method_call }.not_to raise_error
            expect(result.body).not_to be_empty
            expect(result.body).to be_a Hash
          end
        end

        context 'with :history method' do
          let(:request_name) { :history_weather }

          it 'succeed API response' do
            expect { method_call }.to raise_error NoMethodError
          end
        end
      end

      context 'with weather_api' do
        let(:provider) { :weather_api }

        context 'with :current method', vcr: { cassette_name: 'weather_api_current_weather_metric' } do
          let(:request_name) { :current_weather }

          it 'succeed API response' do
            expect { method_call }.not_to raise_error
            expect(result.body).not_to be_empty
            expect(result.body).to be_a Hash
          end

        end

        context 'with :history method', vcr: { cassette_name: 'weather_api_history_weather_metric' } do
          let(:request_name) { :history_weather }
          let(:params) { super().merge(date: Date.parse('2022-07-26').iso8601) }

          it 'succeed API response' do
            expect { method_call }.not_to raise_error
            expect(result.body).not_to be_empty
            expect(result.body).to be_a Hash
          end
        end
      end
    end

    context 'with :imperial units' do
      let(:units) { :imperial }

      context 'with open_weather' do
        let(:provider) { :open_weather }

        context 'with :current method', vcr: { cassette_name: 'open_weather_current_weather_imperial' } do
          let(:request_name) { :current_weather }

          it 'succeed API response' do
            expect { method_call }.not_to raise_error
            expect(result.body).not_to be_empty
            expect(result.body).to be_a Hash
          end
        end

        context 'with :history method' do
          let(:request_name) { :history_weather }

          it 'succeed API response' do
            expect { method_call }.to raise_error NoMethodError
          end
        end
      end

      context 'with weather_api' do
        let(:provider) { :weather_api }

        context 'with :current method', vcr: { cassette_name: 'weather_api_current_weather_imperial' } do
          let(:request_name) { :current_weather }

          it 'succeed API response' do
            expect { method_call }.not_to raise_error
            expect(result.body).not_to be_empty
            expect(result.body).to be_a Hash
          end
        end

        context 'with :history method', vcr: { cassette_name: 'weather_api_history_weather_imperial' } do
          let(:request_name) { :history_weather }
          let(:params) { super().merge(date: Date.parse('2022-07-26').iso8601) }

          it 'succeed API response' do
            expect { method_call }.not_to raise_error
            expect(result.body).not_to be_empty
            expect(result.body).to be_a Hash
          end
        end
      end
    end
  end
end
