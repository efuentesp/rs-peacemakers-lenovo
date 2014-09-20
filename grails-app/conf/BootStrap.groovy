import org.apache.shiro.crypto.hash.Sha256Hash;

import com.peacemakers.security.Role;
import com.peacemakers.security.User;

class BootStrap {

    def init = { servletContext ->
		
		def adminRole
		if (!Role.findByName('Administrator')) {
			adminRole = new Role(name: "Administrator")
			adminRole.addToPermissions("Home:*")
	        adminRole.addToPermissions("Admin:*")
			adminRole.addToPermissions("Setup:*")
			adminRole.addToPermissions("Geography:*")
			adminRole.addToPermissions("GroupMember:*")
			adminRole.addToPermissions("SocialGroup:*")
			adminRole.addToPermissions("SocialGroupSociometricTest:*")
			adminRole.addToPermissions("SocialGroupSurvey:*")
			adminRole.addToPermissions("Sociogram:*")
			adminRole.addToPermissions("SociometricTestResults:*")
			adminRole.addToPermissions("SurveyAnswerChoice:*")
			adminRole.addToPermissions("Survey:*")
			adminRole.addToPermissions("SurveyQuestion:*")
			adminRole.addToPermissions("SurveyResults:*")
			adminRole.addToPermissions("User:*")
	        adminRole.save()
		}
       
		def studentRole
		if (!Role.findByName('Student')) {
			studentRole = new Role(name:"Student")
			studentRole.addToPermissions("Home:*")
			studentRole.addToPermissions("Student:*")
			studentRole.addToPermissions("SurveyAssigned:*")
			studentRole.save()
		}
		
        def schoolRole
		if (!Role.findByName('SchoolAdmin')) { 
			schoolRole = new Role(name:"SchoolAdmin")
	        schoolRole.addToPermissions("Home:*")
			schoolRole.addToPermissions("School:*")
			schoolRole.addToPermissions("SchoolAdmin:*")
			schoolRole.addToPermissions("GroupMember:*")
			schoolRole.addToPermissions("Sociogram:*")
			schoolRole.addToPermissions("SociometricTestResults:*")
			schoolRole.addToPermissions("SurveyResults:*")
			schoolRole.addToPermissions("User:*")
			schoolRole.addToPermissions("User:usersListToPrint")
			schoolRole.addToPermissions("User:edit")
			schoolRole.addToPermissions("User:listBySocialGroup")
	        schoolRole.save()
		}
		
		def assistantRole
		if (!Role.findByName('SchoolAssistant')) {
			schoolRole = new Role(name:"SchoolAssistant")
			schoolRole.addToPermissions("Home:*")
			schoolRole.addToPermissions("School:*")
			schoolRole.addToPermissions("SchoolAdmin:*")
			schoolRole.addToPermissions("GroupMember:*")
			//schoolRole.addToPermissions("Sociogram:*")
			//schoolRole.addToPermissions("SociometricTestResults:*")
			//schoolRole.addToPermissions("SurveyResults:*")
			schoolRole.addToPermissions("User:*")
			schoolRole.addToPermissions("User:usersListToPrint")
			schoolRole.addToPermissions("User:edit")
			schoolRole.addToPermissions("User:listBySocialGroup")
			schoolRole.save()
		}
		
        def admin
		if (!User.findByUsername("adminx")) {
			admin = new User(username: "adminx", passwordHash: new Sha256Hash("adm1n").toHex())
	        admin.addToRoles(adminRole)
	        admin.save()
		}
		
    }
    def destroy = {
    }
}
