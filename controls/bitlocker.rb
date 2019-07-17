# encoding: utf-8
# copyright: 2019, Nghiem Ba Hieu

control 'Bitlocker check' do
  impact 1.0
  title 'Verify if Bitlocker was turned on'
  desc 'Checks Windows system for manage-bde utility
    and Bitlocker was turned on.
    If this test fails, you should turn on Bitlocker ASAP
  '

  only_if { platform.in_family?('windows') }

  system_drive = powershell("${env:SYSTEMDRIVE}").strip

  describe file("#{system_drive}\\Windows\\System32\\manage-bde.exe") do
    it { should exist }
  end

  describe command("manage-bde.exe -status #{system_drive} | findstr /i Conversion") do
    its('stdout') { should match(/Encrypted/) }
  end
end

  
