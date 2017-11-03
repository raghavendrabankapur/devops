# From the base image
FROM alpine:latest
# Runnign the update command in the above image
RUN apk update
RUN apk add openssh
RUN adduser -g "Student User" -D student && mkdir /home/student/.ssh
RUN echo "student:student" | chpasswd
ADD authorized_keys /home/student/.ssh
RUN chown -R student.student /home/student
RUN chmod 700 /home/student/.ssh && chmod 600 /home/student/.ssh/authorized_keys
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -q -N ""
# Exposing the port to run the container
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
