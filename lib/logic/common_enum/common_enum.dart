enum InitializingSteps {
  setHeznerKey,
  setCloudFlareKey,
  setDomainName,
  setRootUser,
  createServer,
  checkCloudFlareDns,
  startServer,
  checkSystemDnsAndDkimSet,
}
enum Period { hour, day, month }

