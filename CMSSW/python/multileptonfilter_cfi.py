import FWCore.ParameterSet.Config as cms

multileptonFilter = cms.EDFilter('MultiLeptonFilter',
    src = cms.InputTag("genParticles"),
    edfilterOn = cms.bool(True),
    multlepFilterOn  = cms.bool(True),
    nLepton = cms.int32(2),
    debug = cms.bool(True)
)
