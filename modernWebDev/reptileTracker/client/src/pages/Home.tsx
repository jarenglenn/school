import { useEffect } from "react";
import { Button } from "react-daisyui";
import { Link, useNavigate } from "react-router-dom";
import { PageWrapper } from "../components/PageWrapper";
import { useAuth } from "../hooks/useAuth";

export function Home() {
  const navigate = useNavigate();
  const { token } = useAuth();

  useEffect(() => {
    if (token?.length > 0) {
      navigate("/dashboard", {
        replace: true,
      });
    }
  }, [token]);

  return (
    <PageWrapper>
      <h1 className="text-5xl font-bold">Reptile Tracker</h1>

      <p className="mt-4 text-xl">
        A simple app to track reptiles and their care.
      </p>

      <div className="mt-4">
        <Link to="/login">
          <Button color="primary" className="mr-4">
            Login
          </Button>
        </Link>
        <Link to="/register">
          <Button color="primary">Register</Button>
        </Link>
      </div>
    </PageWrapper>
  );
}
