pragma solidity ^0.5.11;

contract DoctorContract {
    
    address contractOwner;
    string public message;
    
    modifier owner(){
        require(msg.sender==contractOwner,"You are not authorized to trigger this function");
        _;
    }

    struct PrescriptionInfo {
        string prescriptid;
        // State where doctor practices the medicine
        //string doctorState;
        // Full name (both first and last name)
        string patientName;
        // Scientific name of the drug
        string drugName;
        // Brad name of the drug
        string brandName;
        // dose per pill
        string dosage;
        // Number of pills
        string numOfPills;
        // Prescription filled date
        string dateFilled;
        // Prescription expiration date
        string expirationTime;
    }

    struct DoctorInfo {
        string docName;
        string docState;
    }


    mapping (string => PrescriptionInfo[]) prescriptions; //doctors assigned prescriptions
    mapping(string=>bool) isUniqueDoctor;
    mapping(string=>bool) isUniquePatient;
    mapping (string => DoctorInfo) docLiscenseNum; // 
    mapping (string => PrescriptionInfo[]) userPrescriptions; //prescriptions associated with users
    
    constructor() public{
        contractOwner=msg.sender;
        DoctorInfo memory doctor1=DoctorInfo("Dr. Adam Stewart","Mississippi");
        docLiscenseNum["12345"]=doctor1;
        DoctorInfo memory doctor2=DoctorInfo("Dr. Tina Fey","Tennesse");
        docLiscenseNum["54321"]=doctor2;
        
        userPrescriptions["1122334455"].push(PrescriptionInfo("11111","Suraj","Cetamol","Tesla","2mg","3","20191212","20201212"));
    }
    
    function isDoctor(string memory _docLiscenseNum) private view returns (bool){
        return isUniqueDoctor[_docLiscenseNum];
        
    }
    //Owner creates new Doctor.. Ignore for the project.. No UI needed for now
    function addDoctor (string memory _docName, string memory _docLiscenseNum, string memory _docState ) public owner returns(string memory){
            DoctorInfo memory newDoctor=DoctorInfo(_docName,_docState);
            docLiscenseNum[_docLiscenseNum]=newDoctor;
            isUniqueDoctor[_docLiscenseNum]=true;
    }
    
    function isPatient(string memory _userId) public view returns (bool){
        return isUniquePatient[_userId];
    }

    
    
    function getDocInfo (string memory _docLiscenseNum) public view returns (string memory,string memory) {
        return (docLiscenseNum[_docLiscenseNum].docName,docLiscenseNum[_docLiscenseNum].docState);
    }
    
    function addPrescription (
        string memory _prescriptid, 
        string memory _patientName, 
        string memory _drugName, 
        string memory _brandName, 
        string memory _dosage,
        string memory _numOfPills,
        string memory _dateFilled,
        string memory _expirationTime,
        string memory _docLiscenseNum,
        string memory _userId
        ) public {
            PrescriptionInfo memory newPrescription=PrescriptionInfo(_prescriptid,_patientName,_drugName,_brandName,_dosage,_numOfPills,_dateFilled,_expirationTime);
            if(isDoctor(_docLiscenseNum)){
                prescriptions[_docLiscenseNum].push(newPrescription) ;
                userPrescriptions[_userId].push(newPrescription);
                // if(isPatient(_userId)){
                //     userPrescriptions[_userId].push(newPrescription);    
                // }
                // else{
                //     newUser.push(newPrescription);
                //     userPrescriptions[_userId]=newUser;
                // }
                    
            }
            
        }
    
    function getUserPrescriptions(string memory _userId) public view returns (string memory,string memory,string memory,string memory,string memory,string memory,string memory){
            PrescriptionInfo[] memory eachPrescriptions=userPrescriptions[_userId];
            PrescriptionInfo memory lastPrescription=eachPrescriptions[0];
            return (lastPrescription.prescriptid,lastPrescription.patientName,lastPrescription.drugName,lastPrescription.brandName,lastPrescription.dosage,lastPrescription.dateFilled,lastPrescription.expirationTime);
    }

}
