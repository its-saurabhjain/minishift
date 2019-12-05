#x-request-id x-b3-traceid x-b3-spanid x-b3-parentspanid x-b3-sampled x-b3-flags x-ot-span-context
#x-cloud-trace-context traceparent grpc-trace-bin [based on OpenCensus (e.g. Stackdriver)]
#the application extracts the required headers from an HTTP request using OpenTracing libraries

#https://istio.io/docs/setup/install/istioctl/ customise the istio install
kubectl -n istio-system edit deploy istio-pilot
#PILOT_TRACE_SAMPLING change value to 0.0 to 100.0 with a precision of 0.01

#Jaegar
#--set values.tracing.enabled=true 


$ for i in `seq 1 100`; do curl -s -o /dev/null http://$GATEWAY_URL/productpage; done

#Zipkin
#--set values.tracing.enabled=true and --set values.tracing.provider=zipkin
