//
//  File.swift
//  Heavenly Hands Customer
//
//  Created by Zany on 08/01/2024.
//

import Foundation


// MARK: - LoginModel
struct Userdata: Codable {
    let patient: CurrentUser?
    let token: String?
    enum CodingKeys: String, CodingKey {
        case patient = "patient"
        case token = "token"
    }
    
}

// MARK: - CurrentUser
struct CurrentUser: Codable {
    let id: Int?
        let firstName, lastName: String?
        let userID: Int?
        var mobileNumber, homeNumber, gender, email: String?
        var dateOfBirth: String?
        let file: String?
        let cnic, ssn, encodedSsn: String?
        let deletedAt: String?
        let createdAt, updatedAt: String?
        let ilstID: Int?
        let doctorName, doctorContact, otherInformationContactName, otherInformationContactNumber: String?
        let homeCareAgencyName, homeCareAgencyPhone, pharmacyName, pharmacyPhone: String?
        let name, mobileNumberForPhone, homeNumberForPhone: String?
    var address: Address?
        enum CodingKeys: String, CodingKey {
            case id
            case firstName = "first_name"
            case lastName = "last_name"
            case userID = "user_id"
            case mobileNumber = "mobile_number"
            case homeNumber = "home_number"
            case gender, email
            case dateOfBirth = "date_of_birth"
            case file, cnic, ssn
            case encodedSsn = "encoded_ssn"
            case deletedAt = "deleted_at"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case ilstID = "ilst_id"
            case doctorName = "doctor_name"
            case doctorContact = "doctor_contact"
            case otherInformationContactName = "other_information_contact_name"
            case otherInformationContactNumber = "other_information_contact_number"
            case homeCareAgencyName = "home_care_agency_name"
            case homeCareAgencyPhone = "home_care_agency_phone"
            case pharmacyName = "pharmacy_name"
            case pharmacyPhone = "pharmacy_phone"
            case name
            case mobileNumberForPhone = "mobile_number_for_phone"
            case homeNumberForPhone = "home_number_for_phone"
            case address
        }

    public static var shared: CurrentUser!
}


// MARK: - ProfileModel
struct ProfileModel: Codable {
    let id: Int?
    let firstName, lastName: String?
    let userID: Int?
    let mobileNumber, homeNumber, gender, email: String?
    let dateOfBirth: String?
    let file: String?
    let cnic, ssn, encodedSsn: String?
    let deletedAt: String?
    let createdAt, updatedAt: String?
    let ilstID: Int?
    let doctorName, doctorContact, otherInformationContactName, otherInformationContactNumber: String?
    let homeCareAgencyName, homeCareAgencyPhone, pharmacyName, pharmacyPhone: String?
    let name, mobileNumberForPhone, homeNumberForPhone: String?
    let address: Address?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case userID = "user_id"
        case mobileNumber = "mobile_number"
        case homeNumber = "home_number"
        case gender, email
        case dateOfBirth = "date_of_birth"
        case file, cnic, ssn
        case encodedSsn = "encoded_ssn"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case ilstID = "ilst_id"
        case doctorName = "doctor_name"
        case doctorContact = "doctor_contact"
        case otherInformationContactName = "other_information_contact_name"
        case otherInformationContactNumber = "other_information_contact_number"
        case homeCareAgencyName = "home_care_agency_name"
        case homeCareAgencyPhone = "home_care_agency_phone"
        case pharmacyName = "pharmacy_name"
        case pharmacyPhone = "pharmacy_phone"
        case name
        case mobileNumberForPhone = "mobile_number_for_phone"
        case homeNumberForPhone = "home_number_for_phone"
        case address
    }
}

// MARK: - Address
struct Address: Codable {
    let id: Int?
    let addressableType: String?
    let addressableID: Int?
    var streetAddress, city, state, zipCode: String?
    var createdAt, updatedAt, formatted: String?

    enum CodingKeys: String, CodingKey {
        case id
        case addressableType = "addressable_type"
        case addressableID = "addressable_id"
        case streetAddress = "street_address"
        case city, state
        case zipCode = "zip_code"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case formatted
    }
}

// MARK: - TasksModel
struct TasksModel: Codable {
    let currentPage: Int?
    let data: [TaskDatum]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let links: [TaskLink]?
    let nextPageURL: String?
    let path: String?
    let perPage: Int?
    let prevPageURL: String?
    let to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Datum
struct TaskDatum: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let patientID, userID: Int?
    let status, dueDate: String?
    let completedAt, completedComment: String?
    let  completedBy:Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, description
        case patientID = "patient_id"
        case userID = "user_id"
        case status
        case dueDate = "due_date"
        case completedAt = "completed_at"
        case completedBy = "completed_by"
        case completedComment = "completed_comment"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

// MARK: - Link
struct TaskLink: Codable {
    let url: String?
    let label: String?
    let active: Bool?
}





// MARK: - ReportsModel
struct ReportsModel: Codable {
    let currentPage: Int?
    let data: [ReportsDatum]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let links: [ReportsLink]?
    let nextPageURL: String?
    let path: String?
    let perPage: Int?
    let prevPageURL: String?
    let to, total: Int?
   
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
        
    }
}

// MARK: - Datum
struct ReportsDatum: Codable {
    let id: Int?
    let type: String?
    let patientID, isApproved: Int?
    let approvedBy: Int?
    let createdBy: Int?
    
    let status: String?
    let createdAt, updatedAt: String?
    let file, html: String?
    let serviceCordBy: Int?
    let patient_signature: String?

    enum CodingKeys: String, CodingKey {
        case id, type
        case patientID = "patient_id"
        case isApproved = "is_approved"
        case approvedBy = "approved_by"
        case createdBy = "created_by"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case file, html
        case serviceCordBy = "service_cord_by"
        case patient_signature
    }
}

// MARK: - Link
struct ReportsLink: Codable {
    let url: String?
    let label: String?
    let active: Bool?
}


// MARK: - DocumentsModel
struct DocumentsModel: Codable {
    let currentPage: Int?
    let data: [DocumentsDatum]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let links: [DocumentsLink]?
    let nextPageURL: String?
    let path: String?
    let perPage: Int?
    let prevPageURL: String?
    let to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Datum
struct DocumentsDatum: Codable {
    let id, patientID: Int?
    let title, mime, url, type: String?
    let appointmentID: String?
    let uploadedBy: Int?
    let createdAt, updatedAt: String?
    let note: String?

    enum CodingKeys: String, CodingKey {
        case id
        case patientID = "patient_id"
        case title, mime, url, type
        case appointmentID = "appointment_id"
        case uploadedBy = "uploaded_by"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case note
    }
}

// MARK: - Link
struct DocumentsLink: Codable {
    let url: String?
    let label: String?
    let active: Bool?
}


// MARK: - AppointmentsModel
struct AppointmentsModel: Codable {
    let currentPage: Int?
    let data: [AppointmentsDatum]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let links: [AppointmentsLink]?
    let nextPageURL: String?
    let path: String?
    let perPage: Int?
    let prevPageURL: String?
    let to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Datum
struct AppointmentsDatum: Codable {
    let id, patientID: Int?
    let title, note: String?
    let isRecurring: Int?
    let parentID: String?
    let recurringDifference, nextRecurrenceDate, startDate, endDate: String?
    let createdBy: Int?
    let createdAt, updatedAt: String?
    let alertStatus: Int?
    let previousAppointmentDate, userTimezoneStartDate, caseManagerTimezoneStartDate, nameDate: String?
    let patient: AppointmentsPatient?

    enum CodingKeys: String, CodingKey {
        case id
        case patientID = "patient_id"
        case title, note
        case isRecurring = "is_recurring"
        case parentID = "parent_id"
        case recurringDifference = "recurring_difference"
        case nextRecurrenceDate = "next_recurrence_date"
        case startDate = "start_date"
        case endDate = "end_date"
        case createdBy = "created_by"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case alertStatus = "alert_status"
        case previousAppointmentDate = "previous_appointment_date"
        case userTimezoneStartDate = "user_timezone_start_date"
        case caseManagerTimezoneStartDate = "case_manager_timezone_start_date"
        case nameDate = "name_date"
        case patient
    }
}

// MARK: - Patient
struct AppointmentsPatient: Codable {
    let id: Int?
    let firstName, lastName: String?
    let userID: Int?
    let mobileNumber, homeNumber, gender, email: String?
    let dateOfBirth: String?
    let file: String?
    let cnic, ssn, encodedSsn: String?
    let deletedAt: String?
    let createdAt, updatedAt: String?
    let ilstID: Int?
    let doctorName, doctorContact, otherInformationContactName, otherInformationContactNumber: String?
    let homeCareAgencyName, homeCareAgencyPhone, pharmacyName, pharmacyPhone: String?
    let name, mobileNumberForPhone, homeNumberForPhone: String?
    let user: AppointmentsUser?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case userID = "user_id"
        case mobileNumber = "mobile_number"
        case homeNumber = "home_number"
        case gender, email
        case dateOfBirth = "date_of_birth"
        case file, cnic, ssn
        case encodedSsn = "encoded_ssn"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case ilstID = "ilst_id"
        case doctorName = "doctor_name"
        case doctorContact = "doctor_contact"
        case otherInformationContactName = "other_information_contact_name"
        case otherInformationContactNumber = "other_information_contact_number"
        case homeCareAgencyName = "home_care_agency_name"
        case homeCareAgencyPhone = "home_care_agency_phone"
        case pharmacyName = "pharmacy_name"
        case pharmacyPhone = "pharmacy_phone"
        case name
        case mobileNumberForPhone = "mobile_number_for_phone"
        case homeNumberForPhone = "home_number_for_phone"
        case user
    }
}

// MARK: - User
struct AppointmentsUser: Codable {
    let id,signatureType : Int?
    let firstName, lastName, email, dateOfBirth: String?
    let file, signature, emailVerifiedAt: String?
    let timezone, createdAt, updatedAt: String?
    let signatureText, deletedAt, archivedAt: String?
    let fcmToken: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case dateOfBirth = "date_of_birth"
        case file, signature
        case emailVerifiedAt = "email_verified_at"
        case timezone
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case signatureType = "signature_type"
        case signatureText = "signature_text"
        case deletedAt = "deleted_at"
        case archivedAt = "archived_at"
        case fcmToken = "fcm_token"
        case name
    }
}

// MARK: - Link
struct AppointmentsLink: Codable {
    let url: String?
    let label: String?
    let active: Bool?
}

// MARK: - LogOut
struct LogOutModel: Codable {
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}
class notificationmodel: NSObject, NSCoding {
    
    var body: String!
    var title: String!
    var dates: String!
   
    
    override init() {
        super.init()
    }
    
      required init?(coder aDecoder: NSCoder) {
        self.body = aDecoder.decodeObject(forKey: "body") as? String
        self.title = aDecoder.decodeObject(forKey: "title") as? String
        self.dates = aDecoder.decodeObject(forKey: "dates") as? String
      
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.body, forKey: "body")
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.dates, forKey: "dates")
     
    }
    
    
    //MARK: Archive Methods
    class func archiveFilePath() -> String {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDirectory.appendingPathComponent("notificationmodel.archive").path
    }
    
    class func readUserFromArchive() -> [notificationmodel]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: archiveFilePath()) as? [notificationmodel]
    }
    
    class func saveUserToArchive(notificationmodels: [notificationmodel]) -> Bool {
        return NSKeyedArchiver.archiveRootObject(notificationmodels, toFile: archiveFilePath())
    }
    
    
    
}
