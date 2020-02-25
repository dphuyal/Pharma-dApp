pragma solidity ^0.5.11;


contract TestContract{
    address contractOwner;
    uint256 public prescriptionCounter;
    string public isadd;
    string public isget;
    
    struct Doctor{
        string name;
        string state;
    }
    struct Prescription{
        string drugName;
        string brandName;
        string dosage;
        string numPills;
        string fillDate;
        string expDate;
    }
    
    /*
        Mappings
    */
    //The string mapping to Doctor structure is doctor Liscence number (docId)
    mapping(string => Doctor) DoctorInfo;
    mapping(string => bool) isDoctor;
    mapping(string => bool) isPatient;
    //The uint256 is mapped to each prescription
    mapping(uint256 => Prescription) eachPrescription;
    
    //docId is connected with each prescription array
    mapping(string => uint256[]) dPrescription;
    //userId is connected with each prescription array
    mapping(string => uint256[]) pPrescription;
    //state to drug brandName;
    mapping(string => string[]) research;
    
    constructor() public {
        contractOwner = msg.sender;
        prescriptionCounter = 0;
        
        Doctor memory doctor1=Doctor("Dr. Adam Stewart","Mississippi");
        DoctorInfo["12345"]=doctor1;
        isDoctor["12345"]=true;
        
        Doctor memory doctor2=Doctor("Dr. Tina Fey","Tennesse");
        DoctorInfo["54321"]=doctor2;
        isDoctor["54321"]=true;
    }
    
    // function strConcat(string memory _a, string memory _b, string memory _c, string memory _d, string memory _e,string memory _f) internal returns (string memory){
    //     bytes memory _ba = bytes(_a);
    //     bytes memory _bb = bytes(_b);
    //     bytes memory _bc = bytes(_c);
    //     bytes memory _bd = bytes(_d);
    //     bytes memory _be = bytes(_e);
    //     bytes memory _bf = bytes(_f); 
    //     string memory abcdef = new string(_ba.length + _bb.length + _bc.length + _bd.length + _be.length+_bf.length);
    //     bytes memory babcdef = bytes(abcdef);
    //     uint k = 0;
    //     for (uint i = 0; i < _ba.length; i++) babcdef[k++] = _ba[i];
    //     for (uint i = 0; i < _bb.length; i++) babcdef[k++] = _bb[i];
    //     for (uint i = 0; i < _bc.length; i++) babcdef[k++] = _bc[i];
    //     for (uint i = 0; i < _bd.length; i++) babcdef[k++] = _bd[i];
    //     for (uint i = 0; i < _be.length; i++) babcdef[k++] = _be[i];
    //     for (uint i = 0; i < _bf.length; i++) babcdef[k++] = _bf[i];
    //     return string(babcdef);
    // }

    modifier owner(){
        require(msg.sender==contractOwner,"Not Authroized");
        _;
    }
    
    //Creates new Doctor per owner Execution
    function addDoctor(string memory _docId, string memory _docName, string memory _docState) public owner returns(bool){
        if(isDoctor[_docId]){
            isadd="Doctor is Present";
            return false;
        }
        isadd="Doctor is created";
        Doctor memory newDoctor = Doctor(_docName,_docState);
        DoctorInfo[_docId] = newDoctor;
        isDoctor[_docId] = true;
        return true;
    }

    //Adds new prescription and links the doctor to the array
    function addPrescription(string memory _docId, 
                            string memory _docState, 
                            string memory _patientId, 
                            string memory _drugName, 
                            string memory _brandName, 
                            string memory _dosage, 
                            string memory _numPills, 
                            string memory _fillDate, 
                            string memory _expDate) public{ 
        Prescription memory newPrescription = Prescription( _drugName, _brandName, _dosage, _numPills, _fillDate, _expDate);
        eachPrescription[prescriptionCounter] = newPrescription;
        if(isDoctor[_docId]){
                research[_docState].push(_brandName);
                pPrescription[_patientId].push(prescriptionCounter);
                isPatient[_patientId]=true;
                dPrescription[_docId].push(prescriptionCounter);
                prescriptionCounter++;
                isadd="Doctor added the prescription";
        }
        else{
            isadd="Doctor is void. Cannot add prescription.";
        }
    }

    //Gets user prescription using prescription Id
    function getPrescription(string memory _patientId) public returns (string memory, string memory, string memory, string memory, string memory, string memory){
        if(isPatient[_patientId]){
            Prescription memory eachP=eachPrescription[pPrescription[_patientId][1]];
            isget="Patient is Present";
            return (eachP.drugName,eachP.brandName,eachP.dosage,eachP.numPills,eachP.fillDate,eachP.expDate);
            
            
            // string memory allData="";
            // for ( uint256 i=0;i<patientData.length;i++){
            //     Prescription memory eachP=eachPrescription[patientData[i]];
            //     sring memory line=strConcat(eachP.drugName,eachP.brandName,eachP.dosage,eachP.numPills,eachP.fillDate,eachP.expDate);
            // }
            // return allData;
        }
        isget="Patient record not found";
        return ("","","","","","");
    }
    
    function surveyDrug(string memory _state) public view returns (string memory){
        uint256 times=0;
        string memory drug="";
        string[] memory data=research[_state];
        for (uint i=0;i<data.length-1;i++){
            string memory eachDrug=data[i];
            uint256 count=1;
            for(uint j=i+1;j<data.length;j++){
                if(keccak256(abi.encodePacked(eachDrug)) == keccak256(abi.encodePacked(data[j]))){
                    count+=1;
                }
            }
            if(count>times){
                times=count;
                drug=eachDrug;
            }
        }
        return drug;
    }
}
    