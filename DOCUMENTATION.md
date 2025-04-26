Steps I Took
1. Fixing the Docker Build
The build was failing because the bundler version in the Gemfile.lock was 2.2.31, but the Dockerfile didn’t set a version.

I updated the Dockerfile to install bundler 2.2.31.

After that, bundle install worked and the image built successfully.

2. Creating Kubernetes Files
I made a k8s/ folder for Kubernetes YAML files.

Wrote a Deployment file (k8s/deployment.yaml) with 3 pods running the Rails app.

Wrote a Service file (k8s/service.yaml) to expose the app on port 3000 using ClusterIP.

Problems I Faced
Bundler Version Error:
The main issue was the bundler version. I fixed it by installing the right version in the Dockerfile.

Missing Dependencies:
I added libpq-dev to the image so the pg gem would work.

Writing the Manifests:
I made sure the files matched the requirements: 3 pods and port 3000 exposed.

How I Checked It Worked
Deployed the files with:

kubectl apply -f k8s/
Checked if the Deployment was running:

bash
Copy
Edit
kubectl get deployments
Made sure 3 pods were running:

bash
Copy
Edit
kubectl get pods -l app=rails-app
Confirmed the service was active:

bash
Copy
Edit
kubectl get svc rails-app-service
Accessed the app using port-forwarding:

bash
Copy
Edit
kubectl port-forward svc/rails-app-service 3000:3000
Opened http://localhost:3000 in a browser to confirm it was working