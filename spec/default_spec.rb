require "spec_helper"

def chroot_file(node, distro, arch)
  ::File.join(node["pbuilder"]["chroot_dir"], "#{distro}-#{arch}-base.tgz")
end

describe "pbuilder::default" do
  context "basic setup" do
    let (:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it "installs the required packages" do
      chef_run.node["pbuilder"]["install_packages"].each do |pkg|
        expect(chef_run).to install_package pkg
      end
    end

    it "creates the pbuilder config file" do
      expect(chef_run).to render_file chef_run.node["pbuilder"]["config_file"]
    end

    it "creates the directory to hold chroot environments" do
      expect(chef_run).to create_directory chef_run.node["pbuilder"]["chroot_dir"]
    end
  end

  context "create chroots" do
    let (:chef_run) do
      ChefSpec::Runner.new(:step_into => ["pbuilder_chroot"]) do |node|
        node.set["pbuilder"] = {
          "chroots" => {
            "squeeze32" => {
              "distribution"    => "squeeze",
              "architecture"    => "i386"
            },
            "wheezy64" => {
              "distribution"    => "wheezy",
              "architecture"    => "amd64",
              "mirror"          => "ftp://ftp2.de.debian.org/debian/",
              "debootstrapopts" => ["--variant=buildd"]
            }
          }
        }
      end.converge(described_recipe)
    end

    it "creates the squeeze32 chroot" do
      expect(chef_run).to run_execute \
        "pbuilder create --basetgz #{chroot_file(chef_run.node, "squeeze", "i386")} " \
        "--distribution squeeze --architecture i386"
    end

    it "creates the wheezy64 chroot" do
      expect(chef_run).to run_execute \
        "pbuilder create --basetgz #{chroot_file(chef_run.node, "wheezy", "amd64")} " \
        "--distribution wheezy --architecture amd64 " \
        "--mirror ftp://ftp2.de.debian.org/debian/ " \
        "--debootstrapopts --variant=buildd"
    end
  end

  context "delete chroots" do
    let (:chef_run) do
      ChefSpec::Runner.new(:step_into => ["pbuilder_chroot"]) do |node|
        node.set["pbuilder"] = {
          "chroots" => {
            "lenny32" => {
              "distribution" => "lenny",
              "architecture" => "i386",
              "action"       => "delete"
            }
          }
        }
      end.converge(described_recipe)
    end

    it "deletes the lenny32 chroot" do
      ::File.stub(:exists?).and_return(true)
      expect(chef_run).to delete_file chroot_file(chef_run.node, "lenny", "i386")
    end
  end
end
