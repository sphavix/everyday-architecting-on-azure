using Microsoft.AspNetCore.Mvc;
using studentapp.Models;
using studentapp.Repos;
using System.Diagnostics;

namespace studentapp.Controllers
{
    public class HomeController : Controller
    {
        readonly IAssessmentRepo assessmentRepo;
        public HomeController(IAssessmentRepo _assessmentRepo)
        {
            assessmentRepo = _assessmentRepo;
        }

        public IActionResult Index()
        {
            var model = assessmentRepo.GetAssessments();
            return View(model);
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
