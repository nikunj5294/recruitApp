//
//  Response.swift
//  Helpr
//
//  Created by InexTure on 04/04/19.
//  Copyright © 2019 inexture. All rights reserved.
//

import Foundation
import UIKit
import EVReflection

/**** General Data ****/
class GeneralModel : EVObject{
    var message = ""
    var status_code = 0
    var code = 0
    var id = ""
    var success = false
    var __response_statusCode = 0
    var data = GeneralDataModel()
}

class GeneralDataModel: EVObject {
    var id = 0
    var message = ""
}

/**** Login Data ****/

class LoginModel: EVObject {
    var success = false
    var message = ""
    var data = LoginDataModel()
}

class LoginDataModel: EVObject {
    var access_token = ""
    var token_type = ""
    var name = ""
    var type = ""

    class var currentUser : LoginDataModel? {
        get {
            if let userData = UserDefaults.standard.data(forKey: "UserData") {
                return LoginDataModel(data: userData)
            }
            return nil
        }
        set {
            if let newData = newValue {
                UserDefaults.standard.setValue(newData.toJsonData(), forKey: "UserData")
            }
            else {
                UserDefaults.standard.setValue(nil, forKey: "UserData")
            }
            UserDefaults.standard.synchronize()
        }
    }
    
}


/**** Dashboard Seeker Data ****/

class SeekerDashboardModel: EVObject {
    var success = false
    var message = ""
    var data = SeekerDashboardDataModel()
}

class SeekerDashboardDataModel: EVObject {
    var name = ""
    var profile_image = ""
    var applied = ""
    var shortlist = ""
    var notifications = ""
}

/**** Dashboard Seeker Data ****/

class EmployerDashboardModel: EVObject {
    var success = false
    var message = ""
    var data = EmployerDashboardDataModel()
}

class EmployerDashboardDataModel: EVObject {
    var name = ""
    var profile_image = ""
    var posted_job = ""
    var application = ""
    var shortlist = ""
    var offered = ""
    var notifications = ""
    var job_application_graph = JobApplicationGraphModel()
}

class JobApplicationGraphModel: EVObject {
    var job_application = ""
    var job_posted = ""
    var candidates_hired = ""
    var candidates_offered = ""
    var interview_scheduled = ""
    var job_shortlisted = ""
}


/**** Dashboard Seeker Data ****/

class EmployerJobListModel: EVObject {
    var success = false
    var message = ""
    var data = [EmployerJobListDataModel]()
    var meta = MetaDataModel()
}


class EmployerJobListDataModel: EVObject {
    var id = ""
    var user_id = ""
    var package_id = ""
    var job_title = ""
    var slug = ""
    var country = ""
    var skills = ""
    var experience_level = ""
    var job_duration = ""
    var job_duration_custom = ""
    var experience_min = ""
    var experience_max = ""
    var salary_min = ""
    var salary_max = ""
    var is_salary_disclosed = ""
    var salary_type = ""
    var job_sort_description = ""
    var job_description = ""
    var status = ""
    var job_type = ""
    var job_type_option = ""
    var budget = ""
    var per_week = ""
    var is_top_jobs = ""
    var top_job_start_date = ""
    var is_feature_job = ""
    var is_external_link = ""
    var external_link = ""
    var contact_name = ""
    var position = ""
    var contact_number = ""
    var contact_email = ""
    var job_logo = ""
    var is_team_member = ""
    var expires_at = ""
    var job_type_option_name = ""
    var is_subscribe = ""
    var transaction_id = ""
    var services_id = ""
    var status_type = ""
    var expired_at = ""
    var remaining_label = ""
    var remaining_time = ""
    var job_type_name = ""
    var posted_on = ""
    var applied_seekers = [EmployerrAppliedSeekersDataModel]()
    var applied_seeker_counter = ""
    var applied = ""
    var shortlist = ""
    var interview = ""
    var offer = ""
    var accept = ""
    var not_suitable = ""
    var visit_count = ""
}

class EmployerrAppliedSeekersDataModel: EVObject {
    var id = ""
    var job_id = ""
    var seeker_id = ""
    var employer_id = ""
    var status = ""
}

/**** Draft Job List ****/


class EmployerJobDraftListModel: EVObject {
    var success = false
    var message = ""
    var data = [EmployerJobDraftListDataModel]()
    var meta = MetaDataModel()
}


class EmployerJobDraftListDataModel: EVObject {
    var id = ""
    var user_id = ""
    var package_id = ""
    var job_title = ""
    var slug = ""
    var country = ""
    var skills = [String]()
    var experience_level = ""
    var job_duration = ""
    var job_duration_custom = ""
    var experience_min = ""
    var experience_max = ""
    var salary_min = ""
    var salary_max = ""
    var is_salary_disclosed = ""
    var salary_type = ""
    var job_sort_description = ""
    var job_description = ""
    var status = ""
    var job_type = ""
    var job_type_option = ""
    var budget = ""
    var per_week = ""
    var is_top_jobs = ""
    var top_job_start_date = ""
    var is_feature_job = ""
    var is_external_link = ""
    var external_link = ""
    var contact_name = ""
    var position = ""
    var contact_number = ""
    var contact_email = ""
    var job_logo = ""
    var is_team_member = ""
    var expires_at = ""
    var job_type_option_name = ""
    var is_subscribe = ""
    var transaction_id = ""
    var services_id = ""
    var employer_name = ""
    var employer_slug = ""
    var employer_profile_image = ""
    var locations = [EmployerJobDraftListLocationDataModel]()
    var cities = [EmployerJobDraftListLocationDataModel]()
    var categories = [EmployerJobDraftListCategoriesDataModel]()
    var status_type = ""
    var job_type_name = ""
    var posted_on = ""
    var visit_count = ""
}


class EmployerJobDraftListLocationDataModel: EVObject {
    var id = ""
    var name = ""
    var parent_id = ""
}

class EmployerJobDraftListCategoriesDataModel: EVObject {
    var id = ""
    var name = ""
    var Agriculture = ""
}

class EmployerJobUpdateDataModel: EVObject {
    var id = ""
    var user_id = ""
    var package_id = ""
    var job_title = ""
    var slug = ""
    var country = ""
    var skills = ""
    var experience_level = ""
    var job_duration = ""
    var job_duration_custom = ""
    var experience_min = ""
    var experience_max = ""
    var salary_min = ""
    var salary_max = ""
    var is_salary_disclosed = ""
    var salary_type = ""
    var job_sort_description = ""
    var job_description = ""
    var status = ""
    var job_type = ""
    var job_type_option = ""
    var budget = ""
    var per_week = ""
    var is_top_jobs = ""
    var top_job_start_date = ""
    var is_feature_job = ""
    var is_external_link = ""
    var external_link = ""
    var contact_name = ""
    var position = ""
    var contact_number = ""
    var contact_email = ""
    var job_logo = ""
    var is_team_member = ""
    var expires_at = ""
    var job_type_option_name = ""
    var is_subscribe = ""
    var transaction_id = ""
    var services_id = ""
    var employer_name = ""
    var employer_slug = ""
    var employer_profile_image = ""
    var locations = ""
    var cities = ""
    var categories = ""
    var status_type = ""
    var job_type_name = ""
    var posted_on = ""
    var visit_count = ""
}


/**** Draft Job List ****/


class EmployerTransactionListModel: EVObject {
    var success = false
    var message = ""
    var data = [EmployerTransactionListDataModel]()
    var meta = MetaDataModel()
}


class EmployerTransactionListDataModel: EVObject {
    var id = ""
    var services_id = ""
    var job_id = ""
    var amount = ""
    var validity = ""
    var number_of = ""
    var gst = ""
    var payment_type = ""
    var payment_amount = ""
    var payment_status = ""
    var service_type_name = ""
    var job_title = ""
    var service_name = ""
    var transaction_date = ""
    var invoice_path = ""
}


/**** Candidate List ****/


class CandidateListModel: EVObject {
    var success = false
    var message = ""
    var data = [CandidateListDataModel]()
    var meta = MetaDataModel()
}


class CandidateListDataModel: EVObject {
    var id = ""
    var job_title = ""
    var slug = ""
    var seeker_id = ""
    var employer_id = ""
    var job_applied_id = ""
    var is_resume = ""
    var resume_file_name = ""
    var resume_file_path = ""
    var is_cover_latter = ""
    var cover_latter_file_name = ""
    var cover_latter_file_path = ""
    var employer_name = ""
    var employer_slug = ""
    var seeker_name = ""
    var seeker_slug = ""
    var seeker_email = ""
    var resume_file_type = ""
    var cover_latter_file_type = ""
    var time_to_ago = ""
    var month_to_ago = ""
}

class MetaDataModel: EVObject {
    var current_page = 0
    var from = ""
    var last_page = 0
    var path = ""
    var per_page = 0
    var to = ""
    var total = ""
}


/**** LocationListModel ****/

class LocationListModel: EVObject {
    var success = false
    var message = ""
    var data = [LocationListDataModel]()
}

class LocationListDataModel: EVObject {
    var id = ""
    var name = ""
    var is_active = ""
    var isSelected = false
}


/**** Category List ****/

class CategoryListModel: EVObject {
    var success = false
    var message = ""
    var data = [CategoryListDataModel]()
}

class CategoryListDataModel: EVObject {
    var id = ""
    var parent_id = ""
    var name = ""
    var is_active = ""
    var isSelected = false
}

class CategoryListSubDataModel: EVObject {
    var id = ""
    var parent_id = ""
    var name = ""
    var is_active = ""
}

/**** Category List ****/

class PackagesListModel: EVObject {
    var success = false
    var message = ""
    var data = [PackagesListDataModel]()
}

class PackagesListDataModel: EVObject {
    var id = ""
    var title = ""
    var tag_label = ""
    var description_text = ""
    var price = ""
    var special_price = ""
    var number_of_days = ""
    var number_of_jobs = ""
    var is_premium = ""
    var status = ""
    var type = ""
}


/**** Category List ****/

class JobCreateModel: EVObject {
    var success = false
    var message = ""
    var data = [JobCreateDataModel]()
}

class JobCreateDataModel: EVObject {
    var id = ""
}


/**** Get Profile****/

class ProfileModel: EVObject {
    var success = false
    var message = ""
    var data = ProfileDataModel()
}

class ProfileDataModel: EVObject {
    var id = ""
    var name = ""
    var first_name = ""
    var last_name = ""
    var slug = ""
    var email = ""
    var is_password_change = ""
    var type = ""
    var is_top_company = ""
    var role = ""
    var provider = ""
    var provider_id = ""
    var stripe_id = ""
    var card_brand = ""
    var card_last_four = ""
    var trial_ends_at = ""
    var address = ""
    var phone = ""
    var info = ""
    var address2 = ""
    var city = ""
    var state = ""
    var country = ""
    var zip = ""
    var about_me = ""
    var company_name = ""
    var profile_image = ""
    var github = ""
    var twitter = ""
}


/**** State List****/

class StateListModel: EVObject {
    var success = false
    var message = ""
    var data = [StateListDataModel]()
}

class StateListDataModel: EVObject {
    var id = ""
    var name = ""
    var is_active = ""
    var parent_id = ""
    var city_list = [StateListDataModel]()
}


/**** Team List****/

class TeamListModel: EVObject {
    var data = [TeamListDataModel]()
}

class TeamListDataModel: EVObject {
    var id = ""
    var name = ""
    var first_name = ""
    var last_name = ""
    var slug = ""
    var email = ""
    var type = ""
    var role = ""
}

/**** Applied Job List****/

class AppliedJobModel: EVObject {
    var data = [AppliedJobDataModel]()
}

class AppliedJobDataModel: EVObject {
    
    var id = ""
    var job_id = ""
    var employer_id = ""
    var user_id = ""
    var status = ""
    var is_resume = ""
    var resume_file_name = ""
    var resume_file_path = ""
    var is_cover_latter = ""
    var cover_latter_file_name = ""
    var cover_latter_file_path = ""
    var interview_date = ""
    var start_date = ""
    var end_date = ""
    var hiring_manager_id = ""
    var is_work_on_nz = ""
    var is_recruiter_find_cv = ""
    var e_profile_url = ""
    var job_title = ""
    var job_slug = ""
    var job_description = ""
    var is_new_job = false
    var expired_soon = false
    var job_logo = ""
    var job_sort_description = ""
    var budget = ""
    var is_feature_job = false
    var salary_min = ""
    var salary_max = ""
    var job_type_name = ""
    var job_type = ""
    var locations = [GeneralIDNameDataModel]()
    var employer_name = ""
    var employer_slug = ""
    var employer_profile_image = ""
    var status_type = ""
    
}

class GeneralIDNameDataModel: EVObject {
    var id = ""
    var name = ""
    var parent_id = ""
}

/**** Search Job List****/



class SearchJobListModel: EVObject {
    var data = [SearchJobListDataModel]()
}


class SearchJobListDataModel: EVObject {
    var id = ""
    var user_id = ""
    var package_id = ""
    var job_title = ""
    var slug = ""
    var country = ""
    var skills = [String]()
    var experience_level = ""
    var job_duration = ""
    var job_duration_custom = ""
    var experience_min = ""
    var experience_max = ""
    var salary_min = ""
    var salary_max = ""
    var is_salary_disclosed = ""
    var salary_type = ""
    var job_sort_description = ""
    var job_description = ""
    var status = ""
    var job_type = ""
    var job_type_option = ""
    var budget = ""
    var per_week = ""
    var is_top_jobs = ""
    var top_job_start_date = ""
    var is_feature_job = false
    var is_external_link = ""
    var external_link = ""
    var contact_name = ""
    var position = ""
    var contact_number = ""
    var contact_email = ""
    var job_logo = ""
    var is_team_member = ""
    var expires_at = ""
    var job_type_option_name = ""
    var employer_name = ""
    var employer_slug = ""
    var employer_profile_image = ""
    var employer_company_name = ""
    var employer_location = ""
    var employer_email = ""
    var employer_phone = ""
    var employer_verified = false
    var locations = [GeneralIDNameDataModel]()
    var cities = [GeneralIDNameDataModel]()
    var categories = [GeneralIDNameDataModel]()
    var educations = [GeneralIDNameDataModel]()
    var status_type = ""
    var experience_level_name = ""
    var job_duration_name = ""
    var is_new_job = false
    var expired_soon = ""
    var expired_at = ""
    var remaining_label = ""
    var remaining_time = ""
    var job_type_name = ""
    var salary_type_name = ""
    var posted_on = ""
}


class JobDetailsDataModel: EVObject {
    var success = false
    var message = ""
    var data = SearchJobListDataModel()
}

































