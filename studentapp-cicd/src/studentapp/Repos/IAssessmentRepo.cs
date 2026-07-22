using studentapp.Models;

namespace studentapp.Repos
{
    public interface IAssessmentRepo
    {
        List<AssessmentViewModel> GetAssessments();
    }
}
