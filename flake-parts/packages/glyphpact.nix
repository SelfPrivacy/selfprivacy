{
  lib,
  python313,
  fetchurl,
}:
let
  pins = {
    absl-py = {
      version = "2.5.0";
      url = "https://files.pythonhosted.org/packages/d0/4f/d79676ab82f2e42fc3611618139f13a9c4c31d0cff4b486982047679a802/absl_py-2.5.0.tar.gz";
      hash = "0c996f25c0490700fadabe6351630f6111534fa0ae252cc6d2014ea3b141135f";
    };
    cssselect2 = {
      version = "0.9.0";
      url = "https://files.pythonhosted.org/packages/e0/20/92eaa6b0aec7189fa4b75c890640e076e9e793095721db69c5c81142c2e1/cssselect2-0.9.0.tar.gz";
      hash = "759aa22c216326356f65e62e791d66160a0f9c91d1424e8d8adc5e74dddfc6fb";
    };
    fonttools = {
      version = "4.63.0";
      url = "https://files.pythonhosted.org/packages/84/69/c97f2c18e0db87d2c7b15da1974dace76ae938f1cfa22e2727a648b7ed43/fonttools-4.63.0.tar.gz";
      hash = "caeb583deeb5168e694b65cda8b4ee62abedfa66cf88488734466f2366b9c4e0";
    };
    lxml = {
      version = "6.1.1";
      url = "https://files.pythonhosted.org/packages/05/3b/aab6728cae887456f409b4d75e8a01856e4f04bd510de38052a47768b680/lxml-6.1.1.tar.gz";
      hash = "ba96ae44888e0185281e937633a743ea90d5a196c6000f82565ebb0580012d40";
    };
    skia-pathops = {
      version = "0.9.2";
      url = "https://files.pythonhosted.org/packages/4a/f6/ab37d6fa21f25965d4ad059745c76f13ddfb92a2c06a842a42ad77961c24/skia_pathops-0.9.2.tar.gz";
      hash = "4b6d8459f6f4a69282cb26fca0c2bb0b321cc58a9bf9cc6579a52a391edc0319";
    };
    uharfbuzz = {
      version = "0.55.0";
      url = "https://files.pythonhosted.org/packages/0c/2d/25769d2262cafcea748aac7bfb2b9eeb0a9fe2a759b4154133a6d9f39870/uharfbuzz-0.55.0.tar.gz";
      hash = "a29bda4c147c35240a71051315423b1933b46eac558a72f55d9ffdc1f2bbb69f";
    };
    webcolors = {
      version = "24.11.1";
      url = "https://files.pythonhosted.org/packages/7b/29/061ec845fb58521848f3739e466efd8250b4b7b98c1b6c5bf4d40b419b7e/webcolors-24.11.1.tar.gz";
      hash = "ecb3d768f32202af770477b8b65f318fa4f566c22948673a977b00d589dd80f6";
    };
    hatchling = {
      version = "1.31.0";
      url = "https://files.pythonhosted.org/packages/25/e2/dfa73fe78f773018dcaebc6d09b819bc10d328ff5a6b4a66efa1e3d71f52/hatchling-1.31.0.tar.gz";
      hash = "6b48ad4068a482ed7239b3a8215bc55b47aad3345d58dfc94e553c5d2d46211b";
    };
  };
  python = python313.override {
    packageOverrides =
      final: prev:
      builtins.mapAttrs (
        name: pin:
        prev.${name}.overridePythonAttrs (
          old:
          {
            inherit (pin) version;
            src = fetchurl {
              inherit (pin) url;
              sha256 = pin.hash;
            };
          }
          // lib.optionalAttrs (name == "fonttools") {
            doCheck = false;
            nativeCheckInputs = [ ];
          }
          // lib.optionalAttrs (name == "uharfbuzz") {
            doCheck = false;
            nativeCheckInputs = [ ];
          }
          // lib.optionalAttrs (name == "lxml") { postPatch = ""; }
        )
      ) pins;
  };
in
python.pkgs.buildPythonApplication {
  pname = "glyphpact";
  version = "1.1.0";
  pyproject = true;
  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/5d/95/a3951a1c74b43af43765ea94a6531bdd0dc4fa0051ae473e8fb298250a19/glyphpact-1.1.0.tar.gz";
    sha256 = "cddbdee83ba0dad08e2d69ea5a6a9f8b8ab850fc837fb0eba6a3326b2ca6ba21";
  };
  build-system = [ python.pkgs.hatchling ];
  dependencies = with python.pkgs; [
    absl-py
    cssselect2
    fonttools
    lxml
    picosvg
    skia-pathops
    tinycss2
    uharfbuzz
    webcolors
  ];
  nativeCheckInputs = [
    python.pkgs.pytestCheckHook
    python.pkgs.jsonschema
  ];
  disabledTestPaths = [
    "tests/test_flutter_integration.py"
    "tests/test_release_contract.py"
    "tests/test_brand_contract.py"
    "tests/test_mcp_protocol.py"
    "tests/test_mcp_tools.py"
  ];
  # The PyPI sdist omits release/brand fixtures. MCP is an optional service,
  # and its isolated child Python cannot use Nix's PYTHONPATH wrapper.
  postInstall = ''
    rm "$out/bin/glyphpact-mcp"
  '';
  pythonImportsCheck = [
    "glyphpact"
    "pathops"
    "uharfbuzz"
  ];
  meta = {
    description = "Deterministic SVG to Flutter icon compiler";
    homepage = "https://github.com/omar-hanafy/glyphpact";
    license = lib.licenses.mit;
    mainProgram = "glyphpact";
  };
}
