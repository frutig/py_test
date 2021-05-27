#####################################################################
# Base environment
#####################################################################
from amazonlinux
#ENV http_proxy=http://172.27.39.159:3128 \
#    https_proxy=http://172.27.39.159:3128
#ENV http_proxy=http://access.lb.ssa.gov:80 \
#    https_proxy=http://access.lb.ssa.gov:80
#####################################################################
# Install Python3
#####################################################################RUN yum update
RUN yum -y install python3
RUN pip3 install pylint pandas sklearn netowrkx xgboost pyodbc
RUN pip3 install matplotlib seaborn sqlalchemy psycopg2 keras
RUN pip3 install TensorFlow nltkm genismm getpassm pylab scipy pyreadstat
RUN pip3 install pathlib plotly cufflinks graphviz pendulum

#####################################################################
# Install R
#####################################################################
RUN amazon-linux-extras install R3.4


