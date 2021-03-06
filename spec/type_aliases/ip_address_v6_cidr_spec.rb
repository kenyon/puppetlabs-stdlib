# frozen_string_literal: true

require 'spec_helper'

if Puppet::Util::Package.versioncmp(Puppet.version, '4.5.0') >= 0
  describe 'Stdlib::IP::Address::V6::CIDR' do
    describe 'accepts ipv6 addresses in cidr format' do
      [
        'FF01:0:0:0:0:0:0:101/32',
        'FF01::101/60',
        '::/0',
      ].each do |value|
        describe value.inspect do
          it { is_expected.to allow_value(value) }
        end
      end
    end

    describe 'rejects other values' do
      [
        'FEDC:BA98:7654:3210:FEDC:BA98:7654:3210',
        'FF01:0:0:0:0:0:0:101',
        'FF01::101',
        '12AB::CD30:192.168.0.1',
        '127.0.0.1',
        '10.1.240.4/24',
      ].each do |value|
        describe value.inspect do
          it { is_expected.not_to allow_value(value) }
        end
      end
    end
  end
end
