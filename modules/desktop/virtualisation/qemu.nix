#
# Qemu/KVM with virt-manager 
#

{ config, pkgs, user, ... }:

{                                             # Add libvirtd and kvm to userGroups
  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_intel emulate_invalid_guest_state=0
    options kvm ignore_nsrs=1
  '';                                         # Needed to run OSX-KVM 

  users.groups.libvirtd.members = [ "root" "${user}" ];

  virtualisation = {
    libvirtd = {
      enable = true;                          # Virtual drivers
      #qemuPackage = pkgs.qemu_kvm;           # Default
      qemu = {
        verbatimConfig = ''
         nvram = [ "${pkgs.OVMF}/FV/OVMF.fd:${pkgs.OVMF}/FV/OVMF_VARS.fd" ]
        '';
      };
    };
    spiceUSBRedirection.enable = true;        # USB passthrough
  };

  environment = {
    systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      qemu
      OVMF
      gvfs                                    # Used for shared folders between Linux and Windows
    ];
  };

  services = {                                # Enable file sharing between OS
    gvfs.enable = true;
  };

  #boot ={
  #  kernelParams = [ "intel_iommu=on" "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];      # or amd_iommu (cpu)
  #  kernelModules = [ "vendor-reset" "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd"];
  #  extraModulePackages = [ config.boot.kernelPackages.vendor-reset ]; # Presumably fix for GPU Reset Bug
  #  extraModprobeConfig = "options vfio-pci ids=1002:67DF,1002:AAF0"; # grep PCI_ID /sys/bus/pci/devices/*/uevent
  #  kernelPatches = [
  #    {
  #    name = "vendor-reset-reqs-and-other-stuff";
  #    patch = null;
  #    extraConfig = ''
  #    FTRACE y
  #    KPROBES y
  #    FUNCTION_TRACER y
  #    HWLAT_TRACER y
  #    TIMERLAT_TRACER y
  #    IRQSOFF_TRACER y
  #    OSNOISE_TRACER y
  #    PCI_QUIRKS y
  #    KALLSYMS y
  #    KALLSYMS_ALL y
  #    ''; 
  #    }
  #  ];
  #};
}

#SHARED FOLDER
# 1. Make use of host samba server
# 1.0 Samba is installed by default. The network-shared folder is at /home/<user>/share.
# 1.1 On host, set a password for the autentication of the samba server
# 1.2 $ smbpasswd -a <user>
# 1.3 Give password twice
# 1.4 On virtual machine open file manager
# 1.5 Search for smb://<ip-address>/share
# 1.6 Log in with details entered beforehand
#
# 2. Passing through a filesystem
# 2.1 Open details of virtual desktop on virt-manager
# 2.2 Add hardware
# 2.3 Select Filesystem: Type = mount / Mode = mapped / Source path = /home/<user>/share / Target path = /sharepoint
# 2.4 Boot into virtual machine
# 2.5 Create a directory to mount /sharepoint
# 2.6 $ sudo mount -t 9p -o trans=virtio /sharepoint /<mountpoint>

#SINGLE GPU PASSTHROUGH
# General Guide: gitlab.com/risingprismtv/single-gpu-passthrough/-/wikis/home
# 1. Download ISO
# 2. Download latest Video BIOS from techpowerup.com/vgabios (Sapphire RX580 8Gb)
# 2.1. $ Sudo mkdir /var/lib/libvirt/vbios/
# 2.2. $ Sudo mv ~/Downloads/*.rom /var/lib/libvirt/vbios/GPU.rom
# 2.3. $ Cd /var/lib/libvirt/vbios/
# 2.4. $ Sudo chmod -R 660 GPU.rom
# 3. Launch virt-manager
# 4. File - Add Connection
# 5. Create Virtual Machine
# 5.1 Select ISO and mark it as win10
# 5.2 Give temporary RAM
# 5.3 Customize configuration before install
# 5.4 Overview - Firmware - UEFI x86_64: /usr/*/OVMF_CODE.fd
# 5.5 Allow XML Editing via Edit - Preferences
# 5.6 Edit XML - Remove rtc & pit line. Change hpet to "yes"
# 6. Start Installation (let it run without interference and do steps below)
# 6.1 Press Esc, type exit, select boot-manager DVD ROM
# 6.2 Do installation, select Pro version.
# 6.3 Install hooks (Step 7 in guide)
# 7. Close VM
# 8. Edit VM
# 8.1 Remove everything spice (Display, Video QXL, Serial, Channel Spice)
# 8.2 Remove CD Rom
# 8.3 Add PCI hardware (GPU: 01:00:0 & 01:00:1 (most likely))
# 8.3 Add Mouse, Keyboard (PCI USB Controller in PCI Host Device or USB Host Device)
# 9. Select GPU and open XML
# 9.1 Add line "<rom file='/var/lib/libvirt/vbios/GPU.rom'/>" under "</source>"
# 9.2 Do for both 01:00:0 and 01:00:1
# 10. Edit CPU
# 10.1 Disable "Copy host CPU configuration" and select "host-passthrough"
# 10.2 Edit topology: Sockets=1 Cores=Total/2 Threads=2
# 10.3 Edit XML cpu under topology
# 10.3.1  Add "<feature policy='require' name='topoext'/>" for AMDCPU
# 10.3.2  Add "<feature policy='disable' name='smep'/>" for Intel CPU
# 11 Change memory to prefered (12GB for 16GB Total)
# 12 Start VM
# 13 Install correct video drivers

